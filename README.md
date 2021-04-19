# moodle-guift-converter

-----------------

## General information

The **_"moodle gift converter"_**, written in perl, transforms a text file into a gift file recognised by Moodle.

-----------------

## How to use it

### Requirements:

This program works in perl, so it is necessary to have an executable of this language.  
We recommend using a Unix distribution that supports it natively.

-----------------

## Use the programe:

To use the program, you just have to type:  
`./texttogift.pl [TextFile] [GiftFile]`  
with:  
`[TextFile] => NameOfTheFile.txt`  
`[GiftFile] => NameOfTheFile.gift`

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

-----------------

## Question Format Examples

#### Multiple choice

>multichoice  
>2. Qui a le premier découvert la relation entre le chômage et l’inflation ?  
>A. Solow  
>B. Samuelson  
>C. Friedman  
>D. Phillips  
>Answer: D


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

-----------------

## Authors

| Last name     |    First name   |      role      
|  -----------  |   ------------  |    --------   
|   Appriou     |      Ronan      |   supervisor   
|   Giard       |      Kenan      | lead developer 

-----------------
## License
This program is under the GPL license see LICENSE.txt
