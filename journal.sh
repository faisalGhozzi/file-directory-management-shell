#!/bin/bash

show_usage()
{
 printf "$0: [-h] [-T] [-t] [-n] [-N] [-d] [-m] [-s] [-g] chemin.." 2> wrong_usage.log; exit 1;
}

ouvrir_help()
{
    cat help.txt
}

Afficher_plot()
{
    python3 main.py $1
}

nb()
{
    ls -l /home/$USER/$1 | wc -l > $1_journal.txt
}

Afficher_version()
{
    echo "version 2.7 , authors : chaima ben slimene and lamis hammami"
}

Afficher_fichier()
{
    ls -p /home/$USER/$1 | grep -v / > ~/$1_journal.txt
    sed -i "1i{$1}" ~/$1_journal.txt
}

Afficher_dossier()
{
    ls -d /home/$USER/${1}*/ | awk -F "/" '{print $4}' > ~/$1_journal.txt
    sed -i "1i{$1}" ~/$1_journal.txt
}

Chercher_directeryUser()
{
   stat -c "%U" /home/$USER/$1 >> ~/$1_journal.txt
}

 Afficher_fonction_acess()
{
   stat -c %x /home/$USER/$1 >> ~/$1_journal.txt
}

 Afficher_fonction_modification_de_date()
{
   stat -c %y /home/$USER/$1 >> ~/$1_journal.txt
}

Menu_graphique(){




    HEIGHT=15
    WIDTH=125
    CHOICE_HEIGHT=5
    TITLE="Sujet 11"
    MENU="Veulliez choisir une option:"

    OPTIONS=(1 "Auteur et version"
            2 "Recuperer fichiers"
            3 "Recuperer dossiers"
            4 "Recuperer nombre dossiers et fichiers"
            5 "Recuperer nom propriétaire"
            6 "Recuperer date dernier access"
            7 "Recuperer date derniere modification"
            8 "Bar plot nombre dossiers/fichiers")

    exec 3>&1

    CHOICE=$(dialog --clear \
                    --title "$TITLE" \
                    --menu "$MENU" \
                    $HEIGHT $WIDTH $CHOICE_HEIGHT \
                    "${OPTIONS[@]}" \
                    2>&1 1>&3)

    clear
    case $CHOICE in
            1)
                dialog --title "Auteurs et Version " \
                --no-collapse \
                --msgbox "version 2.7 , authors : chaima ben slimene and lamis hammami" 20 100
                if [[ $? -eq $DIALOG_OK ]]; then
                Menu_graphique
                fi
                ;;
            2)
                res=$(dialog --stdout --dselect "/home/${USER}/" 50 50)
                Afficher_fichier $res
                dialog --title "Success" \
                --no-collapse \
                --msgbox "Fichier crée avec succes" 20 20
                if [[ $? -eq $DIALOG_OK ]]; then
                Menu_graphique
                fi
                ;;
            3)
                res=$(dialog --stdout --dselect "/home/${USER}/" 50 50)
                Afficher_dossier $res
                dialog --title "Success" \
                --no-collapse \
                --msgbox "Fichier crée avec succes" 20 20
                if [[ $? -eq $DIALOG_OK ]]; then
                Menu_graphique
                fi
                ;;
            4)
                res=$(dialog --stdout --dselect "/home/${USER}/" 50 50)
                nb $res
                dialog --title "Success" \
                --no-collapse \
                --msgbox "Fichier crée avec succes" 20 20
                if [[ $? -eq $DIALOG_OK ]]; then
                Menu_graphique
                fi
                ;;
            5)  res=$(dialog --stdout --dselect "/home/${USER}/" 50 50)
                Chercher_directeryUser $res
                dialog --title "Success" \
                --no-collapse \
                --msgbox "Fichier crée avec succes" 20 20
                if [[ $? -eq $DIALOG_OK ]]; then
                Menu_graphique
                fi
                ;;
            6)  res=$(dialog --stdout --dselect "/home/${USER}/" 50 50)
                Afficher_fonction_acess $res
                dialog --title "Success" \
                --no-collapse \
                --msgbox "Fichier crée avec succes" 20 20
                if [[ $? -eq $DIALOG_OK ]]; then
                Menu_graphique
                fi
                ;;
            7)  res=$(dialog --stdout --dselect "/home/${USER}/" 50 50)
                Afficher_fonction_modification_de_date $res
                dialog --title "Success" \
                --no-collapse \
                --msgbox "Fichier crée avec succes" 20 20
                if [[ $? -eq $DIALOG_OK ]]; then
                Menu_graphique
                fi
                ;;
            8)  res=$(dialog --stdout --dselect "/home/${USER}/" 50 50)
                Afficher_plot $res
                if [[ $? -eq $DIALOG_OK ]]; then
                Menu_graphique
                fi
                ;;
    esac
}

Menu_textuel()
{
    trap "echo 'Control-C ne peut plus etre utilise' ; sleep 1 ; clear ; continue " 1 2 3
    while true
    do
    clear
    echo -e "\t MENU 

    \t [1] \t Afficher le fichier help detaillé a partir d'un fichier text
    \t [2] \t afficher un menu textuel et gerer les fonctionnalité de façon  graphique
    \t [3] \t afficher le nom des auteurs et version du code
   
    \t [4] \t Afficher file qui permet de tracer le non de dossier ainsi que les noms de fichiers
    \t [5] \t Afficher directory qui permet de tracer le non de dossier ainsi que les noms des dossiers
    \t [6] \t afficher la fonction NB qui permet de tracer le nombre des dossier et des fichiers
    \t [7] \t AFFICHER la fonction directory user
    \t [8] \t Afficher la fonction acess 
    \t [9] \t Afficher la fonction datemodif
    \t [10] \t afficher la fonction stat qui permet d'afficher les statistiques
    \t [0] \t QUITTTER 

    \t Entrez un choix [0 - 10]"


    read answer
    clear

    case "$answer" in
        
        1) 
        ouvrir_help
        ;;
        2) 
        Menu_graphique
        ;;
        3) Afficher_version
        ;;
        4) echo "Donner le lien vers le dossier"; read n; Afficher_fichier $n; echo "Trouvez le fichier sous ~/$n.txt"
        ;;
        5) echo "Donner le lien vers le dossier"; read n; Afficher_dossier $n; echo "Trouvez le fichier sous ~/$n.txt"
        ;;
        6) echo "Donner le lien vers le dossier";  read n; nb $n; echo "Trouvez le fichier sous ~/$n.txt"
        ;;
        7) echo "Donner le lien vers le dossier"; read n; Chercher_directeryUser $n; echo "Trouvez le fichier sous ~/$n.txt"
        ;;
        8) echo "Donner le lien vers le dossier"; read n; Afficher_fonction_acess $n; echo "Trouvez le fichier sous ~/$n.txt"
        ;;
        9) echo "Donner le lien vers le dossier"; read n; Afficher_fonction_modification_de_date $n; echo "Trouvez le fichier sous ~/$n.txt"
        ;;
        10) echo "Donner le lien vers le dossier"; read n; Afficher_plot $n
        ;;
        0)  echo "sortie du programme" ; exit 0 ;;
        *)  echo "Choisissez une option affichee dans le menu:" ;;
    esac
    echo ""
    echo "tapez RETURN pour le menu"
    read dummy
    done
}

main()
{
if [ $# -eq 0 ] 
then
    show_usage
    exit 1
else
    while getopts "hgvT:t:n:N:d:m:s:M" opt ; do

    case "${opt}" in
        M)
        Menu_textuel
        ;;
        h) 
        ouvrir_help
        ;;
        g) 
        Menu_graphique
        ;;
        v) Afficher_version
        ;;
        T) Afficher_fichier ${OPTARG}
        ;;
        t) Afficher_dossier ${OPTARG}
        ;;
        n) nb ${OPTARG}
        ;;
        N) Chercher_directeryUser ${OPTARG}
        ;;
        d) Afficher_fonction_acess ${OPTARG}
        ;;
        m) Afficher_fonction_modification_de_date ${OPTARG}
        ;;
        s) Afficher_plot ${OPTARG}
        ;;
    esac
    done
fi
}

main $*