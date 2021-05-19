let express = require('express'),
    app = express(),
    fs = require('fs');

const util = require('util');
const exec = util.promisify(require('child_process').exec);


const jsonParser = express.json();

app.use(express.static(__dirname));

let server = app.listen(8888, function () {
    console.log(`http://localhost:${server.address().port}/`);
});

app.get('/', function (req, res) {
    res.sendFile(__dirname + "\\index.html");
});

app.get('/random', function (req, res) {
    generateCards().then((cards) => {
        res.send(cards)
    })
})

app.post('/check', jsonParser, function (req, res) {
    let places =req.body.info
    checkCards(places).then((msg) => res.send(msg))
})

app.get('/solution', function (req, res) {
    if (current_round.length === 0)
        return res.sendStatus(500)
    findSolution().then((points_loc) => {
        res.send(points_loc)
    });
})


// card utils

const cards = {
    0: "any_card",
    1: "right_corner_card",
    2: "left_corner_card",
    3: "top_bottom_card",
    4: "left_right_card",
    5: "next_card",
    6: "opposite_card",
    7: "next_corner_card",
    8: "not_next_or_opposite_card",
    9: "least_two_spaces_card",
    10: "same_card"
};
const img_names = {
    0: "any.png",
    1: "right_corner.png",
    2: "left_corner.png",
    3: "top_bottom.png",
    4: "left_right.png",
    5: "next.png",
    6: "opposite.png",
    7: "next_corner.png",
    8: "not_next_or_opposite.png",
    9: "not_two_next.png",
    default: "any.png"
}
const colors = {
    0: "white",
    1: "pink",
    2: "yellow",
    3: "orange",
    4: "red",
    5: "green",
    6: "blue",
    7: "black",
    default:
        "grey"
}
const color_variables = {
    "white": "WhiteP",
    "pink": "PinkP",
    "yellow": "YellowP",
    "orange": "OrangeP",
    "red": "RedP",
    "green": "GreenP",
    "blue": "BlueP",
    "black": "BlackP"
}
let current_round = [];
const prolog_path = __dirname + "\\urulu.pl";

class Card {
    constructor(id, my_color) {
        this.id = id
        this.my_color = my_color
        this.color = generateColor(id)
    }

}

function generateColor(id){
    if(id <= 4) return undefined
    return colors[getRandomInt(7)]
}

const generateCards = async () => {
    current_round = []
    let i = -1
    while (i++ < 7)
        current_round.push(new Card(getRandomInt(10), colors[i]));

    let prolog = fs.readFileSync(prolog_path, "utf-8")
    prolog = prolog.split('generated code\r\n')
    let res = prolog[0] + 'generated code\r\n' + generatePredicate()
    fs.writeFileSync(prolog_path, res)

    return getImagesNames(current_round);
}

const getImagesNames = (cards) => {
    return cards.map((x) => {return {img: img_names[x.id], color: x.color}})
}

const findSolution = async () => {
    const {stdout} = await exec(`swipl -f ./urulu.pl -g "command_line()".`)
    let points_places = parseResult(stdout)
    let res_arr = [points_places[0], "", "", "", "", "", "", "", ""]
    for(let i = 1; i< points_places.length; i++) {
        if (points_places[i] === -1) continue
        res_arr[points_places[i]] = colors[i - 1]
    }
    res_arr = res_arr.map((x, index) => x === '' && index > 0?'grey':x)
    return res_arr
}

function parseResult(str_arr) {
    let tokens = str_arr.split(/[\[\],]/).filter((value) => value !== '')
    let result = [Number.parseInt(tokens[0])]
    for(let i = 1; i < tokens.length; i++) {
        if(tokens[i].startsWith('_'))
        {
            result.push(-1)
            continue
        }
        result.push(Number.parseInt(tokens[i].match(/\d/g)[0]));
    }
    return result
}


function generatePredicate() {
    return `round(NegPts, WhiteP, PinkP, YellowP, OrangeP, RedP, GreenP, BlueP, BlackP):- 
                     \tcall_it(${getParams(0)}, NegPts0),
                     \tcall_it(${getParams(1)}, NegPts1),
                     \tcall_it(${getParams(2)}, NegPts2),
                     \tcall_it(${getParams(3)}, NegPts3),
                     \tcall_it(${getParams(4)}, NegPts4),
                     \tcall_it(${getParams(5)}, NegPts5),
                     \tcall_it(${getParams(6)}, NegPts6),
                     \tcall_it(${getParams(7)}, NegPts7),
                     \tNegPts is NegPts0 + NegPts1 + NegPts2 + NegPts3 + NegPts4 + NegPts5 + NegPts6 + NegPts7,
                     \tno_dublicates(WhiteP, PinkP, YellowP, OrangeP, RedP, GreenP, BlueP, BlackP).`
}

function getParams(index) {
    let card = current_round[index]
    if(card.color === undefined)
        return `${cards[card.id]}(${card.my_color}, ${color_variables[card.my_color]})`
    return `${cards[card.id]}(${card.my_color}, ${card.color}, ${color_variables[card.my_color]}, ${color_variables[card.color]})`
}

function getRandomInt(max) {
    return Math.floor(Math.random() * Math.floor(max));
}


async function checkCards(places) {
    let loc = [-1, -1, -1, -1, -1, -1, -1, -1]
    let val = Object.values(colors);
    for(let p in places) {
        if (places[p] === "grey") return "Сірих кольорів не має бути!"
        loc[val.indexOf(places[p])] = p
    }
    if (loc.includes(-1)) return "Колір не має повторюватись!"
    loc = loc.map((x) => x = `loc${(++x)}`)
    const {stdout} = await exec(`swipl -f ./urulu.pl -g "command_line_check([${loc.toString().replace(/\\"/g, "")}])".`)
    return `Ваші очки: ${Number.parseInt(stdout)}`
}

