# moodle-guift-converter

-----------------

## General information

The **_"moodle gift converter"_**, written in perl, transforms a text file into a gift file recognised by Moodle.

-----------------
## Features
### Question name incrementation
You don't have to worry about the question name, it increments by itself.
It automatically adapts to the number of questions.
It will look like this:  
"Question [0-9]" if less than 10 questions in total  
"Question [0-9][0-9]" if between 10 and 100 questions in total  
"Question [0-9][0-9][0-9]" if between 100 and 999(inclusive) total  

### Allow negative point for multichoise with one right answer
You have the option of setting a negative point percentage for single answer multichoice questions.
Note that each question gets 1 point.  
If a question has 4 possible answers : 
- A
- B
- C
- D  

That the correct answer is 'A' and you have set 50% negative points.  
B,C and D are worth '**-0,5**'.

### ponderation multichoice
For the multichoice with several right answers the calculation of the points is done in the following way:  
1. In the case of one wrong answer.  
Point per correct answer = 100 / number of correct answers  
Point for wrong answers = point for right answers

example 1:
- A => right | 100/2
- B => right | 100/2
- C => false |-100/2

example 2: 
- A => right | 100/3
- B => right | 100/3
- C => false |-100/3
- D => right | 100/3
2. In the other cases:  
Point for right answers = 100 / number of right answers  
Point per wrong answers = 100 / (number of answers - point per right answers)

example 1:  
- A => right | 100
- B => false | 100/2
- C => false | 100/2

example 2:  
- A => right | 100/2
- B => right | 100/2
- C => false |-100/2
- D => false |-100/2

example 3:  
- A => right | 100/3
- B => right | 100/3
- C => false |-100/2
- D => false |-100/2
- E => right | 100/3

-----------------
## How to use it

### Requirements:

This program works in perl, so it is necessary to have an executable of this language.  
We recommend using a Unix distribution that supports it natively.


To use the program, you just have to type:  
`./texttogift.pl [TextFile] [GiftFile]`  
with:  
`[TextFile] => NameOfTheFile.txt`  
`[GiftFile] => NameOfTheFile.gift`

If you want to set a negative point make you should use a value between 0 and 100% (it represents the amount of negative point to aplie for each question).
The negative points only affect the multi choice with a single good answer.

For using it type  :   
`./texttogift.pl [TextFile] [GiftFile] [NegativePoint]`

-----------------

## Types of Question

|Question Type 	|Keyword for Converter
|------------ |----------
|Mulptiple choice 	|multichoice
|Short Answer 	|shortanswer
|Essay 	|essay
|True/False 	|truefalse
|Numerical 	|numerical
|Description 	|description

-----------------

## How to prepare a text file

1. Set question type
2. Define answer variants.

>multichoice (question type)  
>1.  Qui a le premier découvert la relation entre le chômage et l’inflation ?(number of the question(dot) question)  
>(Answer variants)  
>A.  Solow  
>B.  Samuelson  
>C.  Friedman  
>D.  Phillips  
>Answer:  D (Answer: Correct Answer)

-----------------

## Question Format Examples

#### Multiple choice

One correct answer
>multichoice  
>2. Qui a le premier découvert la relation entre le chômage et l’inflation ?  
>A. Solow  
>B. Samuelson  
>C. Friedman  
>D. Phillips  
>Answer: D

Multiple correct answers
>multichoice  
>2. Qui a le premier découvert la relation entre le chômage et l’inflation ?  
>A. Fatu Hiva  
>B. Mangareva  
>C. Hiva Oa  
>D. Rimatara  
>Answer: A, C


#### Short Answer

>shortanswer  
>2. Comment dit-on en latin "la plus belle des jeunes femmes" ?  
>Answer: Pulcherrima puella


#### Essay

>essay  
>3. Quelles est la différence entre une collectivité d'outre-mer et un département d'outre-mer ?


#### True/False

>truefalse  
>4. Les adhérences fortes entre les cellules sont facilitées par la formation de jonctions serrées.  
>Answer: True

#### Numerical

>numerical  
>5. Combien il y a t'il îles en Polynésie française ?  
>Answer: 118



#### Description

>description  
>7. Description affiche simplement du texte (et éventuellement des graphiques) sans nécessiter de réponse.

-----------------

## Authors

| Last name     |    First name   |      role      
|  -----------  |   ------------  |    --------   
|   Appriou     |      Ronan      |   supervisor   
|   Giard       |      Kenan      | lead developer 

-----------------
## License
This program is under the GPL license see LICENSE.txt
