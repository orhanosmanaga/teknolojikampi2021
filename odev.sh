#!/bin/bash
echo "Sistemdeki yuklu paket sayisi:"
kactane() {
dpkg --get-selections | wc -l
}
kactane $1

echo "-----------------------------------------"
read -p "Paket adı giriniz : " paketad


function bagimliPaket()
{
 bPaket=$(apt-cache depends $1  | grep Depends |cut -d ':' -f 2)
 bPaketSayi=$(apt-cache depends $1  | grep Depends |cut -d ':' -f 2 | wc -l)
 echo "-----------------------------------------"
echo "paketin baglilik listesi:"
 for ayir in $bPaket
        do
        echo $ayir
        done
echo "-----------------------------------------"
 echo "paketin baglilik sayisi:"
 echo $bPaketSayi
echo "-----------------------------------------"

 for kontrol in $bPaket
        do
        paketyuklumu=$(dpkg-query -l | grep $kontrol | wc -l)

if [ $paketyuklumu -eq 0 ] ; then
        pYO=$pYO+$kontrol




else
        pY=$pY+$kontrol

fi
        done



echo "-----------------------------------------"
echo "yuklu olmayan bagimliliklar  Bunlar: $pYO"
echo "yuklu olmayan bagimliliklar sayisi"
tr '+' '\n' <<<"$pYO"  | wc -l
echo "-----------------------------------------"
echo "yuklu olan bagimliliklar  Bunlar $pY"
echo "yuklu olan bagimliliklar sayisi"
tr '+' '\n' <<<"$pY"  | wc -l
echo "-----------------------------------------"

}

pvarmi() {

echo $'-----1.yontem-----\n'
paketvarmi=$(dpkg -s $paketad | cut -d ':' -f 1 | awk 'NR==1{print}')

if [[ "$paketvarmi" == "Package" ]] ; then
        echo "paket yuklu"
else
        echo $'paket yuklu degil\n'
        bagimliPaket $paketad
fi
}


pvarmi

echo "**********************************************"
echo "**********************************************"


pvarmi2()
{

echo $'-----2.yontem-----\n'
paketvarmi2=$(dpkg-query -l | grep $paketad | wc -l)

if [ $paketvarmi2 -eq 0 ] ; then
        echo $'paket yuklu degil\n'

        bagimliPaket $paketad
else
        echo "paket yuklu"
fi


}

pvarmi2