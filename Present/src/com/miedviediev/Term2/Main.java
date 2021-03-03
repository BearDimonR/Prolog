package com.miedviediev.Term2;

import org.jpl7.Atom;
import org.jpl7.Query;
import org.jpl7.Term;
import org.jpl7.Variable;

public class Main {

    public static void main(String[] args) {


        Query q1 =
                new Query(
                        "consult",
                        new Term[] {new Atom("test.pl")}
                );

        System.out.println( "consult " + (q1.hasSolution() ? "succeeded" : "failed"));




        if(!q1.hasSolution()) return;

//        Query q2 =
//                new Query(
//                        "child_of",
//                        new Term[] {new Atom("joe"),new Atom("ralf")}
//                );
//
//        System.out.println(
//                "\n\nchild_of(joe,ralf) is " +
//                        ( q2.hasSolution() ? "provable" : "not provable" )
//        );
//
//        Query q3 =
//                new Query(
//                        "descendent_of",
//                        new Term[] {new Atom("steve"),new Atom("ralf")}
//                );
//        System.out.println(
//                "\n\ndescendent_of(joe,ralf) is " +
//                        ( q3.hasSolution() ? "provable" : "not provable" )
//        );
//
//


//        Query q4 =
//                new Query(
//                        "descendent_of",
//                        new Term[] {X,new Atom("ralf")}
//                );
//
//
//
//        solution = q4.oneSolution();
//
//        System.out.println( "\n\nfirst solution of descendent_of(X, ralf)");
//        System.out.println( "X = " + solution.get("X"));
//
//
//        Query q5 =
//                new Query(
//                        "descendent_of",
//                        new Term[] {X,new Atom("ralf")}
//                );
//        System.out.println("\n\nall solutions of descendent_of(X, ralf)");
//        java.util.Map<String,Term>[] solutions = q5.allSolutions();
//        for (java.util.Map<String, Term> stringTermMap : solutions) {
//            System.out.println("X = " + stringTermMap.get("X"));
//        }
//        // або
//        while ( q5.hasMoreSolutions()) {
//            solution = q5.nextSolution();
//            System.out.println( "X = " + solution.get("X"));
//        }


        Variable Y = new Variable("Y");
        Variable X = new Variable("X");
        java.util.Map<String,Term> solution;
        Query q6 =
                new Query(
                        "descendent_of",
                        new Term[] {X,Y}
                );

        System.out.println("\n\nReuse:");
        while ( q6.hasMoreSolutions() ){
            solution = q6.nextSolution();
            System.out.println( "X = " +
                    solution.get("X") + ", Y = " +
                    solution.get("Y"));
        }
        q6.close();

    }
}
