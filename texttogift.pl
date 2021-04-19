#!/usr/bin/perl
use strict;
use warnings;
use Try::Tiny;
use 5.010;
sub NumQ {
	my ($num) = @_;
	if ($num < 1000){
		if ($num < 100){
			if($num < 10){
				return ("00$num");
			}
			return("0$num");
		}
		return("$num");
	}
}

if( -e "$ARGV[0]"){ #on verifie qu'un fichier a bien été passer en parametre
	my $negatif = "";
	if($ARGV[2]){
		try {
			if($ARGV[2] =~ m/^\d+$/){
				if(int($ARGV[2])>100)
				{
					print("Veuiller entrer une valeur entre 0 et 100 pour la note négative.\n");
					exit;
				}
				$negatif = "%-$ARGV[2]%";
			}
			else{
				print("ERREUR DE TYPE POUR LA NOTE NEGATIVE (la valeur doit être entière et entre 0 et 100).\n");
				exit;
			}
		}
		catch{
			print("ERREUR POUR LA NOTE NEGATIVE");
			exit;
		}
	}
	
	my $numq ="";
	my( $fe, $fs); # création des variable pour le FichierEntrant et le FichierSortant
	#attribution des fichier
	open($fe,'<',$ARGV[0]);
	open($fs,'>',$ARGV[1]);
	
	my ($le);#création des variable utile
	my $ligne = 0;
	my $type = 0;
	
	while( defined( $le = <$fe> ) ) {#parcour de tous les fichier
	try{
		$ligne++;
		chomp $le;
		$le =~ s/\r//g;
		if( $le =~ m/truefalse/i or ( $le =~ m/\d\./ and $type == 1)){#si la question est un vrais-faux
			if ($le =~ m/\./){}
			else{
				$le = <$fe>;
				$ligne++;
				chomp $le;
				$le =~ s/\r//g;
			}
			$le =~ m/\./;
			$numq = NumQ($`);
			print($fs "::Question_$numq :: $'");
			$le = <$fe>;
			$ligne++;
			if( $le =~ m/True/i ){
				print($fs "{T}\n");
			}
			elsif ($le =~ m/False/i ){
				print($fs "{F}\n");
			}
			else{ 
				print("Une erreur est survenue ligne : $ligne \n");
			}
			$type = 1;
	   }
	   elsif( $le =~ m/multichoice/ or ($le =~ m/\d\./ and $type == 2)){#si la question est a choix multiple
	   #on récupère la question
	   $type = 2;
		if (not($le =~ m/\./)){
			$le = <$fe>;
			$ligne++;
			chomp $le;
			$le =~ s/\r//g;
		}
		$le =~ m/\./;
		$numq = NumQ($`);
		print($fs "::Question_$numq :: $' \n\{ \n"); #on ajoute le titre de la question, l'énoncé puis l'ouverture des réponce
		#on crée un tableau des réponces
		my @t;
		#on remplis ce tableau des réponce possible
		my $cpt = 0;
		$le = <$fe>;
		$ligne++;
		while( $le !~ m/Answer/i){
			chomp $le;
			$le =~ s/\r//g;
			$t[$cpt]=$le;
			$le = <$fe>;
			$ligne++;
			$cpt++;
		}
	#on conte le nombre de réponces proposer et de réponce juste
		my $reponce = @t;#affecter un tableau a une variable retourne sa taille
		my $Breponce = split(/,/,$le);#le est la ligne des Answer en comptant le nombre de virgule+1 on obtion le nombre de reponce
		$le =~ m/Answer:/i; #on retire Answer pour éviter les erreur avec le A
		$le = $';
		if($Breponce eq 1){ # cas pour 1 réponce juste bouton radio
			foreach (@t){
				$_ =~ m/\./;#pour récupéré la lètre de la réponce
				if($le =~ m/$`/){ #si les lêtre de la réponce est dans la ligne des réponce
					$_ =~ m/\./;
					print($fs "=$' \n");
				}
				else{ #si les lêtre de la réponce n'est pas dans la ligne des réponce
					if($negatif ne ""){
						$_ =~ m/\./;
						print($fs "~$negatif$' \n");
					}
					else{
						$_ =~ m/\./;
						print($fs "~$' \n");
					}
				}
			}
			print($fs "\}\n"); #on  oublie pas de fermer les réponces
		}
		else # dans les autres cas
		{
		my ($vj,$vf);#variable pour stocké les % de point par réponces juste ou fausse.
			if($reponce-$Breponce eq 1 or $reponce-$Breponce eq 0){# si 1 réponce fausse
				$vj = 100/$Breponce;
				$vf = $vj
			}
			else{ #dans le reste des cas
				$vj = 100/$Breponce;
				$vf = 100/($reponce-$Breponce);
			}
			
			foreach (@t){
				$_ =~ m/\./;
				if($le =~ m/$`/){ #pour les réponce juste
					$_ =~ m/\./;
					print($fs "~\%$vj\%$' \n");
				}
				else{ #pour les réponces fause
					$_ =~ m/\./;
					print($fs "~\%-$vf\%$' \n");
				}
			}
			print($fs "\}\n");#on  oublie pas de fermer les réponces
		}
		
	   }
	   elsif( $le =~ m/numerical/i or $le =~ m/numérical/i or ($le =~ m/\./ and $type == 3)){ # dans le cas d'une question numérique
			if ($le =~ m/\./){}
			else{
				$le = <$fe>; # on passe le type pour avoir le numérot de question et l'intitulé
				$ligne++;
				chomp $le;
				$le =~ s/\r//g;
			}
			$le =~ m/\./;
			$numq = NumQ($`);
			print($fs "::Question_$numq :: $'");# on indique le titre et la question
			$le = <$fe>; # on vas sur la ligne de ma réponce
			chomp $le;
			$le =~ s/\r//g;
			$ligne++;
			$le =~ m/Answer: /i; # on retire Answer
			print($fs "{#$'}\n"); #on met la réponce entre {}
			$type = 3;
	   }
	   elsif( $le =~ m/shortanswer/i or ($le =~ m/\./ and $type == 4)){ #dans le cas d'une question réponce courte
	   	$le = <$fe>; # on passe le type pour avoir le numérot de question et l'intitulé
	   	$ligne++;
	   	chomp $le;
	   	$le =~ s/\r//g;
	   	$le =~ m/\./;
		$numq = NumQ($`);
		print($fs "::Question_$numq :: $'");# on indique le titre et la question
		$le = <$fe>;# on vas sur la ligne de ma réponce
		chomp $le;
		$le =~ s/\r//g;
		$ligne++;
		print($fs "\n{\n"); #on vas a la ligne et on ouvre les réponces
		$le =~ m/Answer: /i;# on retire Answer
		$le = $'; # vas avec la ligne du dessu
		foreach(split(/, /,$le))#on crée un tableau pour caque valeur en utilisant la virgule comme séparateur puis on parcour le tableau
		{
			print($fs "=$_\n"); #on ajoute toute les réponces
		}
		print($fs "}\n"); # on oublie pas de fermer les réponce et de retourner a la ligne
		$type = 4;
	   }
	   elsif($le =~ m/Essay/i or ($le =~ m/\./ and $type == 5)){
			if ($le =~ m/\./){}
			else{
				$le = <$fe>;
				$ligne++;
				chomp $le;
				$le =~ s/\r//g;
			}
			$le =~ m/\./;
			$numq = NumQ($`);
			print($fs "::Question_$numq :: $'");
			print($fs "\n{}\n");
			$type = 5;
	   }
	   elsif($le =~ m/Description/i or ($le =~ m/\./ and $type == 6)){#si c'est une description 
	   	$le = <$fe>;# on passe le type pour avoir le numérot de question et l'intitulé
   		$ligne++;
   		chomp $le;
   		$le =~ s/\r//g;
	   	print($fs "::$le :: ");#on écrit le titre dans les ::
	   	while($le ne "" ){ #tant qu'on a pas une ligne vide on ajoute toute les ligne les une a la suite des autres
	   		$le = <$fe>;
	   		$ligne++;
	   		chomp $le;
	   		$le =~ s/\r//g;
	   		print($fs "$le ");
	   	}
	   	print($fs "\n\n");#on retourne a la ligne et on saute une ligne
		$type = 6
	   }
	   elsif($le eq "" or $le eq"\n" or $le eq " " or $le eq "\r"){ #si c'est une ligne vide 
	   	print($fs "\n"); #"ont met un saut de ligne"
	   }
	   else{#sonon c'est qu'on a une éreur
	   	print ("erreur ligne: $ligne à ");
	   	while($le !~ m/Answer/i){
	   		$le = <$fe>;
	   		$ligne++;
	   	}
	   	print ("$ligne \n");
	   }
   	} catch{
   		print("erreur dans le block se finissant ligne $ligne\n");
   	}
	}
}
else{
print("le fichier n'existe pas\n");
}

