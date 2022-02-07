
#ifndef LISTASIMPLUI_H_INCLUDED
#define LISTASIMPLUI_H_INCLUDED

//----------------------------------------> Structura de date implementata de Enascuta Razvan Paul <------------------------------------

#endif // LISTASIMPLUI_H_INCLUDED

#include <iostream>
#include <graphics.h>
#include <fstream>

using namespace std;
ifstream fin("Lista.txt");
ofstream fout("Lista.txt");

//int Lungime = 800, Latime = 1600;

int Latime=x;
int Lungime=y;
// string ul in care prelucrez cifrele
char str[10];
int count_noduri = 0;
int animatie = 2000;
bool capat = false;
bool deschis = false;
bool afisare_operatii = false;


// coordonatele nodului initial
int nx = Latime/19.75;
int ny = Lungime/2.49;
int nxx = Latime/6.83;
int nyy = Lungime/2.16;

//coorodnatele casutei, in care se pune informatia/valoarea nodului (elementul cu casuta in stanga si care se deplaseaza spre dreapta)
int valdx = Latime/18.18;
int valdy = Lungime/2.439024;
int valdxx = Latime/10.8843537;
int valdyy = Lungime/10.88435;

//coorodnatele casutei, in care se pune informatia/valoarea nodului (elementul cu casuta in stanga si care se deplaseaza spre dreapta)
int valsx = Latime/1.303993;
int valsy = Lungime/1.895734;
int valsxx = Latime/1.244167;
int valsyy = Lungime/1.7467248;


// coordonatele varfului sagetii -> La dreapta
int vxx = Latime/5.57491;
int vyy1 = Lungime/2.33918;
int vyy2 = Lungime/2.272727;

// coordonatele sagetii -> La dreapta
int sx = Latime/6.808510;
int sxx = Latime/5.479452;
int sy = Lungime/2.305475;
int syy = Lungime/2.305475;

// coordonatele varfului sagetii -> La stanga
int vstgxx = Latime/1.4692;
int vstgyy1 = Lungime/1.83486;
int vstgyy2 = Lungime/1.79372;


// coordonatele sagetii -> La stanga
int stgx = Latime/ 1.40227;
int stgxx = Latime/1.47601;
int stgy = Lungime/1.81405;
int stgyy = Lungime/1.81405;


// deplasez nodul spre dreapta cand apas pe butonul "Adauga Nod"
int deplasare_nod = Latime/7.54;
int deplasare_sageata_coada_varf = Latime/7.547169;
int deplasare_jos_sageata = Lungime/4.16666;
int deplasare_sageata_verticala_jos = Lungime/4.21052;

int latime_sageata = Latime/27.58;

// cu variabila asta stiu care e urmatorul y al sagetii de la nodul indreptat cu pointerul in jos
int deplasare_nod_sageata_jos = Lungime/8.33;

// coordonatele sagetii verticale din partea dreapta
int sdx = Latime/1.26984;
int sdy = Lungime/2.156334;
int sdxx = Latime/1.26984;
int sdyy = Lungime/1.92307;
int sdxx2 = Latime/1.26482;
int sdxx1 = Latime/1.27490;
int sdyy1 = Lungime/1.94647;

// coordonatele sagetii verticale din partea stanga
int sgstgx = Latime/13.114754;
int sgstgy = Lungime/1.713062;
int sgstgxx = Latime/13.114754;
int sgstgyy = Lungime /1.565557;
int sgstgyy1 = Lungime/1.581027;
int sgstgxx1 = Latime/13.675213;
int sgstgxx2 = Latime/12.598425;

// coordonatele NULL -> dreapta orizontal
int ndx1 = Latime/6.808510;
int ndy1 = Lungime/2.305475;
int ndxx1 = Latime/6.0606;
int ndyy2 = Lungime/2.168021;
int ndxx3 = Latime/6.20155;
int ndxx4 = Latime/5.925925;

// coordonatele (bar) count_nod la fiecare casuta -> dreapta
int cndx = Latime/12.59842;
int cndy = Lungime/2.298850;
int cndxx = Latime/10.322580;
int cndyy = Lungime /2.16216;

// coordonatele (bar) count_nod la fiecare casuta -> dreapta
int cnsx = Latime/1.275917;
int cnsy = Lungime/1.809954;
int cnsxx = Latime/3.440860;
int cnsyy = Lungime /1.7241379;
//coordonate afisare_operatii
int afopx = Latime/8.743169;
int afopy = 0;
int afopxx = Latime/2.8368794;
int afopyy = Lungime/2.5;

// coordonate viz operatii
int vopx = Latime / 1.211203;
int vopy =  0;
int vopxx = Latime /  1.00755;
int vopyy = Lungime / 13.793103;


// Variabilele bool cu care stiu in ce parte trebuie sa merg cand adaug noduri/sageti
bool stanga = false;
bool dreapta = true;


//--------------------------> Meniu Functii <---------------------
// Coordonatele cu care afisez/inchid meniul de la functii

int xf = Latime/1.206636;
int yf = Lungime/5.673758;
int xx = Latime/1.0094637;
int yy = Lungime/1.277955;

// Coordonatele pentru butonul inserare la inceput
int xi = Latime / 1.20203;
int xxi = Latime / 1.01265;
int yi = Lungime/ 4.519774;
int yyi = Lungime / 4.123711;

// Coordonatele pentru butonul Inserare pe o anumita pozitie
int ipx = Latime/1.2003;
int ipy = Lungime/3.125;
int ipxx = Latime/1.012658;
int ipyy = Lungime/2.919708;

//Coordonatepe pentru butonul Stergerea primului element din lista

int six = Latime/ 1.187824;
int siy = Lungime/ 2.373887;
int sixx = Latime/ 1.02695;
int siyy = Lungime/2.1052631;

// Coordonatele pentru butonul Stergerea unui element de la sfarsitul listei
int sfx = Latime / 1.198511;
int sfxx = Latime / 1.015873;
int sfy = Lungime / 1.822323;
int sfyy = Lungime / 1.70212;

// Coordonatele pentru butonul Stergerea unui element de pe o anumita pozitie
int spx = Latime/1.198501;
int spy = Lungime/1.498127;
int spxx = Latime/1.01265;
int spyy = Lungime/1.393728;

// Coordonatele pentru butonul Salveaza lista

int savex = Latime / 1.1204481;
int savey = Lungime /1.3333;
int savexx = Latime / 1.0120177;
int saveyy = Lungime /1.2779552;


int valoare;
int pozitie;
int deplasare_cifra = Latime/59;
char numar[2];
char bar_count[1];

int valoarex = Latime/1.588877;

void coordonate_valoare_init(int &valoarex)
{
    valoarex =  Latime/1.588877;
}

void ReinitCoords_li()
{
    Latime=x;
    Lungime=y;

    deplasare_cifra = Latime/59;
    valoarex =  Latime/1.588877;
    // string ul in care prelucrez cifrele
    count_noduri = 0;
    animatie = 2000;


    capat = false;
    deschis = false;
    afisare_operatii = false;
    // coordonatele nodului initial
    nx = Latime/19.75;
    ny = Lungime/2.49;
    nxx = Latime/6.83;
    nyy = Lungime/2.16;

    //coorodnatele casutei, in care se pune informatia/valoarea nodului (elementul cu casuta in stanga si care se deplaseaza spre dreapta)
    valdx = Latime/18.18;
    valdy = Lungime/2.439024;
    valdxx = Latime/10.8843537;
    valdyy = Lungime/10.88435;

    //coorodnatele casutei, in care se pune informatia/valoarea nodului (elementul cu casuta in stanga si care se deplaseaza spre dreapta)
    valsx = Latime/1.303993;
    valsy = Lungime/1.895734;
    valsxx = Latime/1.244167;
    valsyy = Lungime/1.7467248;


    // coordonatele varfului sagetii -> La dreapta
    vxx = Latime/5.57491;
    vyy1 = Lungime/2.33918;
    vyy2 = Lungime/2.272727;

    // coordonatele sagetii -> La dreapta
    sx = Latime/6.808510;
    sxx = Latime/5.479452;
    sy = Lungime/2.305475;
    syy = Lungime/2.305475;

    // coordonatele varfului sagetii -> La stanga
    vstgxx = Latime/1.4692;
    vstgyy1 = Lungime/1.83486;
    vstgyy2 = Lungime/1.79372;


    // coordonatele sagetii -> La stanga
    stgx = Latime/ 1.40227;
    stgxx = Latime/1.47601;
    stgy = Lungime/1.81405;
    stgyy = Lungime/1.81405;


    // deplasez nodul spre dreapta cand apas pe butonul "Adauga Nod"
    deplasare_nod = Latime/7.54;
    deplasare_sageata_coada_varf = Latime/7.547169;
    deplasare_jos_sageata = Lungime/4.16666;
    deplasare_sageata_verticala_jos = Lungime/4.21052;

    latime_sageata = Latime/27.58;

    // cu variabila asta stiu care e urmatorul y al sagetii de la nodul indreptat cu pointerul in jos
    deplasare_nod_sageata_jos = Lungime/8.33;

    // coordonatele sagetii verticale din partea dreapta
    sdx = Latime/1.26984;
    sdy = Lungime/2.156334;
    sdxx = Latime/1.26984;
    sdyy = Lungime/1.92307;
    sdxx2 = Latime/1.26482;
    sdxx1 = Latime/1.27490;
    sdyy1 = Lungime/1.94647;

    // coordonatele sagetii verticale din partea stanga
    sgstgx = Latime/13.114754;
    sgstgy = Lungime/1.713062;
    sgstgxx = Latime/13.114754;
    sgstgyy = Lungime /1.565557;
    sgstgyy1 = Lungime/1.581027;
    sgstgxx1 = Latime/13.675213;
    sgstgxx2 = Latime/12.598425;

    // coordonatele NULL -> dreapta orizontal
    ndx1 = Latime/6.808510;
    ndy1 = Lungime/2.305475;
    ndxx1 = Latime/6.0606;
    ndyy2 = Lungime/2.168021;
    ndxx3 = Latime/6.20155;
    ndxx4 = Latime/5.925925;

    // coordonatele (bar) count_nod la fiecare casuta -> dreapta
    cndx = Latime/12.59842;
    cndy = Lungime/2.298850;
    cndxx = Latime/10.322580;
    cndyy = Lungime /2.16216;

    // coordonatele (bar) count_nod la fiecare casuta -> dreapta
    cnsx = Latime/1.275917;
    cnsy = Lungime/1.809954;
    cnsxx = Latime/3.440860;
    cnsyy = Lungime /1.7241379;
    //coordonate afisare_operatii
    afopx = Latime/8.743169;
    afopy = 0;
    afopxx = Latime/2.8368794;
    afopyy = Lungime/2.5;

    // coordonate viz operatii
    vopx = Latime / 1.211203;
    vopy =  0;
    vopxx = Latime /  1.00755;
    vopyy = Lungime / 13.793103;


    // Variabilele bool cu care stiu in ce parte trebuie sa merg cand adaug noduri/sageti
    stanga = false;
    dreapta = true;


    //--------------------------> Meniu Functii <---------------------
    // Coordonatele cu care afisez/inchid meniul de la functii

    xf = Latime/1.206636;
    yf = Lungime/5.673758;
    xx = Latime/1.0094637;
    yy = Lungime/1.277955;

    // Coordonatele pentru butonul inserare la inceput
    xi = Latime / 1.20203;
    xxi = Latime / 1.01265;
    yi = Lungime/ 4.519774;
    yyi = Lungime / 4.123711;

    // Coordonatele pentru butonul Inserare pe o anumita pozitie
    ipx = Latime/1.2003;
    ipy = Lungime/3.125;
    ipxx = Latime/1.012658;
    ipyy = Lungime/2.919708;

    //Coordonatepe pentru butonul Stergerea primului element din lista

    six = Latime/ 1.187824;
    siy = Lungime/ 2.373887;
    sixx = Latime/ 1.02695;
    siyy = Lungime/2.1052631;

    // Coordonatele pentru butonul Stergerea unui element de la sfarsitul listei
    sfx = Latime / 1.198511;
    sfxx = Latime / 1.015873;
    sfy = Lungime / 1.822323;
    sfyy = Lungime / 1.70212;

    // Coordonatele pentru butonul Stergerea unui element de pe o anumita pozitie
    spx = Latime/1.198501;
    spy = Lungime/1.498127;
    spxx = Latime/1.01265;
    spyy = Lungime/1.393728;

    // Coordonatele pentru butonul Salveaza lista

    savex = Latime / 1.1204481;
    savey = Lungime /1.3333;
    savexx = Latime / 1.0120177;
    saveyy = Lungime /1.2779552;
}

// <---------------------------------------------------------------->
struct nod
{
    int info;
    nod * next;
};

nod * prim = NULL;
nod * ultim = NULL;


struct coord_butoane
{
    float x1,y1,x2,y2;
} coordonateOptiuni,coordonateListe,coordonateListeSimple,coordonateAdaugaNod,coordonatebutonback,coordonateClear,coordonateFunctii,
coordonateInserareInceput,coordonateInserarepozitie,coordonateStergereinceput,coordonatebutonStergereSfarsit,coordonateStergerepozitie,coordonateSalveazaLista,coordonateVizualizareOperatii;



void coordonate_buton_optiuni()
{
    coordonateOptiuni.x1 = Latime/4.77;
    coordonateOptiuni.x2 = Latime/2.22;
    coordonateOptiuni.y1 = Lungime/1.56;
    coordonateOptiuni.y2 = Lungime/1.35;
}
void coordonate_buton_Liste ()
{
    coordonateListe.x1 = Latime/2.51;
    coordonateListe.x2 = Latime/1.77;
    coordonateListe.y1 = Lungime/4.14;
    coordonateListe.y2 = Lungime/2.78;

}
void coordonate_buton_Liste_simple()
{
    coordonateListeSimple.x1 = Latime/1.53;
    coordonateListeSimple.x2 = Latime/1.08;
    coordonateListeSimple.y1 = Lungime/9.4;
    coordonateListeSimple.y2 = Lungime /3.5;
}
void coordonate_buton_Adauga_nod()
{
    coordonateAdaugaNod.x1 = Latime / 2.25;
    coordonateAdaugaNod.x2 = Latime / 1.41;
    coordonateAdaugaNod.y1 = Lungime / 16.6;
    coordonateAdaugaNod.y2 = Lungime / 5.51;
}
void coordonate_buton_clear()
{
    coordonateClear.x1 = Latime / 1.37;
    coordonateClear.x2 = Latime / 1.25;
    coordonateClear.y1 = Lungime / 6.4;
    coordonateClear.y2 = Lungime / 4.21;
}

void coordonate_buton_back_meniu_liste()
{
    coordonatebutonback.x1 = Latime/1.3805;
    coordonatebutonback.x2 = Latime/1.241272;
    coordonatebutonback.y1 = Lungime/100;
    coordonatebutonback.y2 = Lungime/12.12;
}

void coordonate_buton_functii()
{
    coordonateFunctii.x1 = Latime/1.205727;
    coordonateFunctii.x2 = Latime/1.011378;
    coordonateFunctii.y1 = Lungime/12.5;
    coordonateFunctii.y2 = Lungime/6.10687;
}
void coordonate_buton_inserare_inceput()
{
    coordonateInserareInceput.x1 = Latime / 1.202103;
    coordonateInserareInceput.x2 = Latime / 1.01265;
    coordonateInserareInceput.y1 = Lungime/ 4.519774;
    coordonateInserareInceput.y2 = Lungime / 4.123711;
}
void coordonate_inserare_pozitie()
{
    coordonateInserarepozitie.x1 = ipx;
    coordonateInserarepozitie.x2 = ipxx;
    coordonateInserarepozitie.y1 = ipy;
    coordonateInserarepozitie.y2 = ipyy;
}
void coordonate_stergere_inceput()
{
    coordonateStergereinceput.x1 = six;
    coordonateStergereinceput.x2 = sixx;
    coordonateStergereinceput.y1 = siy;
    coordonateStergereinceput.y2 = siyy;
}

void coordonate_buton_stergere_sfarsit()
{
    coordonatebutonStergereSfarsit.x1 = Latime / 1.198501;
    coordonatebutonStergereSfarsit.x2 = Latime / 1.015873;
    coordonatebutonStergereSfarsit.y1 = Lungime / 1.81;
    coordonatebutonStergereSfarsit.y2 = Lungime / 1.70212;
}
void coordonate_stergere_pozitie()
{
    coordonateStergerepozitie.x1 = spx;
    coordonateStergerepozitie.x2 = spxx;
    coordonateStergerepozitie.y1 = spy;
    coordonateStergerepozitie.y2 = spyy;
}
void coordonate_salveaza_lista()
{
    coordonateSalveazaLista.x1 = Latime / 1.121233;
    coordonateSalveazaLista.x2 = Latime / 1.012017;
    coordonateSalveazaLista.y1 = Lungime /1.333;
    coordonateSalveazaLista.y2 = Lungime /1.277955;
}

void coordonate_buton_vizualizare_operatii()
{
    coordonateVizualizareOperatii.x1 = vopx;
    coordonateVizualizareOperatii.x2 = vopxx;
    coordonateVizualizareOperatii.y1 = vopy;
    coordonateVizualizareOperatii.y2 = vopyy;
}

void coordonate_varf_sageata_dreapta_init(int & vxx, int & vyy1, int & vyy2)
{
    vxx = Latime/5.57491;
    vyy1 = Lungime/2.33918;
    vyy2 = Lungime/2.272727;

}

void coordonate_img_nod_initial(int & nx, int & nxx, int & ny, int & nyy)
{
    nx = Latime/19.75;
    ny = Lungime/2.49;
    nxx = Latime/6.83;
    nyy = Lungime/2.16;

}

void coordonate_sageata_dreapta_init(int & sx, int & sxx, int & sy, int & syy)
{
    sx = Latime/6.808510;
    sxx = Latime/5.479452;
    sy = Lungime/2.305475;
    syy = Lungime/2.305475;
}

void coordonate_sageata_jos_dreapta_init(int &sdx,int &sdy,int &sdxx,int &sdyy,int &sdxx1,int &sdyy1,int &sdxx2)
{
    sdx = Latime/1.26984;
    sdy = Lungime/2.156334;
    sdxx = Latime/1.26984;
    sdyy = Lungime/1.92307;
    sdxx2 = Latime/1.26482;
    sdxx1 = Latime/1.27490;
    sdyy1 = Lungime/1.94647;

}

void coordonate_varf_sageata_stanga_init(int & vstgxx, int & vstgyy1, int & vstgyy2)
{
    vstgxx = Latime/1.4692;
    vstgyy1 = Lungime/1.83486;
    vstgyy2 = Lungime/1.79372;
}
void coordonate_sageata_stanga_init(int & stgx, int &stgy, int &stgxx, int &stgyy)
{
    stgx = Latime/ 1.40227;
    stgxx = Latime/1.47601;
    stgy = Lungime/1.81405;
    stgyy = Lungime/1.81405;
}
void coordonate_sageata_jos_stanga_init(int &sgstgx,int &sgstgy,int &sgstgxx,int &sgstgyy,int &sgstgxx1,int &sgstgyy1,int &sgstgxx2)
{
    sgstgx = Latime/13.114754;
    sgstgy = Lungime/1.713062;
    sgstgxx = Latime/13.114754;
    sgstgyy = Lungime /1.565557;
    sgstgyy1 = Lungime/1.581027;
    sgstgxx1 = Latime/13.675213;
    sgstgxx2 = Latime/12.598425;
}

void coordonate_casuta_valori_dreapta_init(int & valdx, int &valdy, int &valdxx, int & valdyy)
{
    valdx = Latime/18.18;
    valdy = Lungime/2.439024;
    valdxx = Latime/10.8843537;
    valdyy = Lungime/10.88435;
}
void coordonate_casuta_valori_stanga_init(int & valsx,int & valsy,int & valsxx,int & valsyy)
{
    valsx = Latime/1.303993;
    valsy = Lungime/1.895734;
    valsxx = Latime/1.244167;
    valsyy = Lungime/1.7467248;
}

void coordonate_bar_count_noduri_dreapta_init(int & cndx, int & cndy, int & cndxx, int & cndyy)
{
    cndx = Latime/12.59842;
    cndy = Lungime/2.298850;
    cndxx = Latime/10.322580;
    cndyy = Lungime /2.16216;

}
void coordonate_bar_count_noduri_stanga_init(int & cnsx, int & cnsy, int & cnsxx, int & cnsyy)
{
    cnsx = Latime/1.275917;
    cnsy = Lungime/1.809954;
    cnsxx = Latime/3.440860;
    cnsyy = Lungime /1.7241379;
}
void coordonate_sageata_initiala_dreapta()
{
    sx = Latime/6.808510;
    sxx = Latime/5.479452;
    sy = Lungime/2.305475;
    syy = Lungime/2.305475;
    vxx = Latime/5.57491;
    vyy1 = Lungime/2.33918;
    vyy2 = Lungime/2.272727;
}
void coordonate_sageata_initiala_stanga()
{
    stgx = Latime/ 1.40227;
    stgxx = Latime/1.47601;
    stgy = Lungime/1.81405;
    stgyy = Lungime/1.81405;
    vstgxx = Latime/1.4692;
    vstgyy1 = Lungime/1.83486;
    vstgyy2 = Lungime/1.79372;
}
void coordonate_sageata_dreapta_stanga_jos()
{
    sdx = Latime/1.26984;
    sdy = Lungime/2.156334;
    sdxx = Latime/1.26984;
    sdyy = Lungime/1.92307;
    sdxx2 = Latime/1.26482;
    sdxx1 = Latime/1.27490;
    sdyy1 = Lungime/1.94647;

}
// Cu functia asta deplasez nodul spre dreapta
void deplasare_img_nod_dreapta(int &nx, int &nxx)
{
    nx+=deplasare_nod;
    nxx+=deplasare_nod;
}
// Cu functia asta deplasez nodul pe randul urmator cand trec la o noua linie
void deplasare_img_nod_jos(int & ny, int & nyy)
{
    ny+=deplasare_nod_sageata_jos;
    nyy+=deplasare_nod_sageata_jos;
}
// Cu functia asta deplasez nodul spre stanga
void deplasare_img_nod_stanga(int & nx, int & nxx)
{
    nx-=deplasare_nod;
    nxx-= deplasare_nod;
}

// Cu functia asta deplasez sageata spre dreapta
void deplasare_sageata_dreapta(int &sx, int &sxx,int & vxx)
{
    sx += deplasare_sageata_coada_varf;
    sxx += deplasare_sageata_coada_varf;
    vxx+= deplasare_sageata_coada_varf;
}

// Cu functia asta deplasez sageata spre stanga
void deplasare_sageata_stanga(int & stgx, int & stgxx,int & vstgxx)
{
    stgx -= deplasare_sageata_coada_varf;
    stgxx -= deplasare_sageata_coada_varf;
    vstgxx -= deplasare_sageata_coada_varf;

}
// Cu functia asta trec cu sageata la randul al 3,5,etc
void deplasare_sageata_dreapta_jos(int &sy,int &syy,int &vyy1,int & vyy2)
{
    sy += deplasare_jos_sageata;
    syy += deplasare_jos_sageata;
    vyy1 += deplasare_jos_sageata;
    vyy2 += deplasare_jos_sageata;
}
// Cu functia asta trec cu sageata la randul 4,6,etc..
void deplasare_sageata_stanga_jos(int &stgy,int&stgyy,int&vstgyy1,int&vstgyy2)
{
    stgy += deplasare_jos_sageata;
    stgyy += deplasare_jos_sageata;
    vstgyy1 += deplasare_jos_sageata;
    vstgyy2 += deplasare_jos_sageata;
}
// Cu functia asta deplasez pe OY sageata indreptata in jos (vertical) din partea dreapta
void deplasare_sageata_jos_dreapta(int &sdy,int&sdyy,int&sdyy1)
{
    sdy += deplasare_sageata_verticala_jos;
    sdyy += deplasare_sageata_verticala_jos;
    sdyy1 += deplasare_sageata_verticala_jos;
}
//Cu functia asta deplasez pe OY sageata indreptata in jos (vertical) din partea stanga
void deplasare_sageata_jos_stanga(int & sgstgy,int &sgstgyy,int &sgstgyy1)
{
    sgstgy += deplasare_sageata_verticala_jos;
    sgstgyy += deplasare_sageata_verticala_jos;
    sgstgyy1 += deplasare_sageata_verticala_jos;
}

// Cu functia asta deplasez coordonatele casutei care detine informatia nodului spre dreapta
void deplasare_coordonate_casuta_valori_dreapta(int & valdx, int &valdxx)
{
    valdx += deplasare_nod;
    valdxx += deplasare_nod;
}
// Cu functia asta deplasez coorodonatele casutei care detine informatia nodului spre stanga
void deplasare_coordonate_casuta_valori_stanga(int & valsx, int & valsxx)
{
    valsx -= deplasare_nod;
    valsxx -= deplasare_nod;
}
// Cu functia asta deplasez coordonatele casutei care detine informatia nodului pe linia 3
void deplasare_coordonate_casuta_valori_dreapta_jos(int & valdy, int & valdyy)
{
    valdy += deplasare_jos_sageata;
    valdyy += deplasare_jos_sageata;
}
// Cu functia asta deplsaez coordonatele casutei care detine informatia nodului pe linia 4
void deplasare_coodronate_casuta_valori_stanga_jos(int & valsy, int & valsyy)
{
    valsy += deplasare_jos_sageata;
    valsyy += deplasare_jos_sageata;
}
// Cu functia asta deplasez count_noduri de la o casuta la alta in directia -> dreapta
void deplasare_bar_count_noduri_dreapta(int & cndx, int & cndxx)
{
    cndx += deplasare_nod;
    cndxx += deplasare_nod;
}
// Cu functia asta deplasez count_noduri de la o casuta la alta in directia -> stanga
void deplasare_bar_count_noduri_stanga(int & cnsx, int & cnsxx)
{
    cnsx -= deplasare_nod;
    cndx -= deplasare_nod;
}
// Cu functia asta deplasez count_noduri de la o casuta la alta in directia -> jos(dreapta)
void deplasare_bar_count_noduri_dreapta_jos(int & cndy, int & cndyy)
{
    cndy += deplasare_jos_sageata;
    cndyy += deplasare_jos_sageata;
}
// Cu functia asta deplasez count_noduri de la o casuta la alta in directia -> jos(stanga)
void deplasare_bar_count_noduri_stanga_jos(int & cnsy, int & cnsyy)
{
    cnsy += deplasare_jos_sageata;
    cnsyy += deplasare_jos_sageata;
}
void init_capat(bool & capat)
{
    capat = false;
}
void reinitializare_stanga_dreapta(bool & stanga, bool & dreapta)
{
    stanga = false;
    dreapta = true;
}
void reinitializare_count_noduri(int & count_noduri)
{
    count_noduri = 0;
}
void deschidere_meniu_functii(bool & deschis)
{
    if(deschis == false)
    {
        readimagefile("JPG/Functii_afisare_meniu.jpg",xf,yf,xx,yy);

        deschis = true;
    }
    else
    {
        readimagefile("JPG/Functii_afisare_inchidere_meniu.jpg",xf,yf,xx,yy);
        deschis = false;
    }
}
// Reinitializez variabila cu care deschid meniul cu functii
void reinitializare_deschis(bool & deschis)
{
    deschis = false;
}
void reinitializare_buton_viz_op(bool & afisare_operatii)
{
    afisare_operatii = false;
}
void deplasare_nod_dreapta(int &nx,int &ny,int &nxx, int &nyy,bool& stanga, bool & dreapta)
{
    if(ny<Lungime/1.206636)
    {
        if(nx<Latime/1.4084)
        {
            readimagefile("JPG/Liste_simple_sageata_dreapta.jpg",nx,ny,nxx,nyy);
            line(sx,sy,sxx,syy);
            line(sxx,syy,vxx,vyy1);
            line(sxx,syy,vxx,vyy2);
            deplasare_sageata_dreapta(sx,sxx,vxx);
            deplasare_img_nod_dreapta(nx,nxx);
        }
        else
        {
            dreapta = false;
            stanga = true;
            readimagefile("JPG/Liste_simple_sageata_jos_dreapta.jpg",nx,ny,nxx,nyy);
            setlinestyle(SOLID_LINE,BLACK,2);
            //line(sx,sy,sxx,syy);
            //line(sxx,syy,vxx,vyy1);
            //line(sxx,syy,vxx,vyy2);
            line(sdx,sdy,sdxx,sdyy);
            line(sdxx,sdyy,sdxx1,sdyy1);
            line(sdxx,sdyy,sdxx2,sdyy1);
            deplasare_sageata_jos_dreapta(sdy,sdyy,sdyy1);
            coordonate_sageata_dreapta_init(sx,sxx,sy,syy);
            coordonate_varf_sageata_dreapta_init(vxx,vyy1,vyy2);
            deplasare_sageata_dreapta_jos(sy,syy,vyy1,vyy2);
            deplasare_img_nod_jos(ny,nyy);
        }
    }

}
void deplasare_nod_stanga(int &nx,int &ny,int &nxx, int &nyy, bool & stanga,bool & dreapta, bool & capat)
{

    if(ny<Lungime/1.206636)
    {
        if(nxx>Latime/6.83)
        {
            readimagefile("JPG/Liste_simple_sageata_stanga.jpg",nx,ny,nxx,nyy);
            line(stgx,stgy,stgxx,stgyy);
            line(stgxx,stgyy,vstgxx,vstgyy1);
            line(stgxx,stgyy,vstgxx,vstgyy2);
            deplasare_sageata_stanga(stgx,stgxx,vstgxx);
            deplasare_img_nod_stanga(nx,nxx);

        }
        else
        {
            stanga = false;
            dreapta = true;
            //nx-=deplasare_nod;
            // nxx-=deplasare_nod;
            readimagefile("JPG/Liste_simple_sageata_jos_stanga.jpg",nx,ny,nxx,nyy);
            if(sgstgyy<Lungime/1.206636)
            {
                line(sgstgx,sgstgy,sgstgxx,sgstgyy);
                line(sgstgxx,sgstgyy,sgstgxx1,sgstgyy1);
                line(sgstgxx,sgstgyy,sgstgxx2,sgstgyy1);
            }
            else
            {
                capat = true;
                line(sgstgx,sgstgy,sgstgxx,sgstgyy);
                line(sgstgxx,sgstgyy,sgstgxx1,sgstgyy1);
                line(sgstgxx,sgstgyy,sgstgxx2,sgstgyy1);
            }

            deplasare_sageata_jos_stanga(sgstgy,sgstgyy,sgstgyy1);
            coordonate_sageata_stanga_init(stgx,stgy,stgxx,stgyy);
            coordonate_varf_sageata_stanga_init(vstgxx,vstgyy1,vstgyy2);
            deplasare_sageata_stanga_jos(stgy,stgyy,vstgyy1,vstgyy2);
            deplasare_img_nod_jos(ny,nyy);
        }
    }
}

void adaugare_nod_la_sfarsit(nod * &prim,nod* &ultim,int valoare,int & count_noduri)
{
    nod* temp = new nod;
    temp->info = valoare;
    if(prim==NULL)
    {
        readimagefile("JPG/main_Lista_simpla_head.jpg",0,0,Latime,Lungime);
        count_noduri = 1;
        prim = temp;
        ultim = temp;
        ultim->next = NULL;
        if(deschis == true)
        {
            reinitializare_deschis(deschis);
            deschidere_meniu_functii(deschis);
        }
        setcolor(BLACK);
        setlinestyle(SOLID_LINE,SOLID_FILL,2);
        coordonate_img_nod_initial(nx,nxx,ny,nyy);
        line(sx,sy,sxx,syy);
        line(sxx,syy,vxx,vyy1);
        line(sxx,syy,vxx,vyy2);
        //line(ndx1,ndy1,ndxx1,ndy1);
        //line(ndxx1,ndy1,ndxx1,ndyy2);
        //line(ndxx1,ndyy2,ndxx3,ndyy2);
        //line(ndxx1,ndyy2,ndxx4,ndyy2);
        deplasare_sageata_dreapta(sx,sxx,vxx);
        readimagefile("JPG/Liste_simple_sageata_dreapta.jpg",nx,ny,nxx,nyy);
        nx+=deplasare_nod;
        nxx+=deplasare_nod;

    }
    else if(capat != true)
    {
        ultim->next = temp;
        ultim = temp;
        ultim->next = NULL;
        count_noduri++;
        if(prim != NULL)
        {
            nod * temp;
            temp = prim;
            cout<<temp->info<<" ";
            while(temp->next != NULL)
            {
                temp = temp->next;
                cout<<temp->info<<" ";
            }
            cout<<endl;
            cout<<count_noduri<<" ";
            cout<<endl;

        }
        //cout<<prim->info<<" "<<ultim->info<<endl;

        if(dreapta==true)
        {
            deplasare_nod_dreapta(nx,ny,nxx,nyy,stanga,dreapta);
            //cout<<"dreapta"<<endl;
        }

        else if(stanga==true)
        {
            deplasare_nod_stanga(nx,ny,nxx,nyy,stanga,dreapta,capat);
            // cout<<"stanga"<<endl;
        }

    }

}
void eroare_trebuie_introduse_doar_cifre()
{
    readimagefile("Erori/Valoarea_trebuie_sa_contina_doar_cifre.jpg",Latime/3.50877,Lungime/2.97397,Latime/1.40227,Lungime/2.684563);
    delay(1000);
    readimagefile("Erori/Inchidere_trebuie_sa_introduceti_doar_cifre.jpg",Latime/3.50877,Lungime/2.97397,Latime/1.40227,Lungime/2.684563);

}
void eroare_ati_depasit_limita_de_cifre()
{
    readimagefile("Erori/Ati_depasit_limita_de_cifre.jpg",Latime/3.50877,Lungime/2.97397,Latime/1.513718,Lungime/2.711864);
    delay(1000);
    readimagefile("Erori/Inchidere_trebuie_sa_introduceti_doar_cifre.jpg",Latime/3.50877,Lungime/2.97397,Latime/1.40227,Lungime/2.684563);
}


void eroare_limita_noduri()
{
    readimagefile("Erori/Limita_noduri_atinsta.jpg",Latime/4.70588,Lungime/4,Latime/1.649484,Lungime/3.555);
    clearmouseclick(WM_LBUTTONDOWN);
    delay(1000);
    readimagefile("Erori/Inchidere_Limita_noduri_atinsa.jpg",Latime/4.70588,Lungime/4,Latime/1.649484,Lungime/3.555);
}
void eroare_nu_exista_noduri_pentru_stergere()
{
    readimagefile("Erori/Nu_exista_noduri_de_sters.jpg",Latime/4.70588,Lungime/4,Latime/1.649484,Lungime/3.555);
    clearmouseclick(WM_LBUTTONDOWN);
    delay(1000);
    readimagefile("Erori/Inchidere_Nu_exista_noduri_de_sters.jpg",Latime/4.70588,Lungime/4,Latime/1.649484,Lungime/3.555);
}
void eroare_nu_exista_element_pe_pozitia_introdusa()
{
    readimagefile("Erori/Nu exista niciun element pe pozitia introdusa.jpg",Latime/4.70588,Lungime/4,Latime/1.649484,Lungime/3.555);
    clearmouseclick(WM_LBUTTONDOWN);
    delay(1000);
    readimagefile("Erori/Inchidere_Limita_noduri_atinsa.jpg",Latime/4.70588,Lungime/4,Latime/1.649484,Lungime/3.555);
}
void lista_a_fost_salvata()
{
    readimagefile("Erori/Deschidere_lista_salvata.jpg",Latime/1.21120363,Lungime/1.257861,Latime/1.005025,Lungime/1.185185);
    delay(500);
    readimagefile("Erori/Inchidere_lista_salvata.jpg",Latime/1.21120363,Lungime/1.257861,Latime/1.005025,Lungime/1.185185);
}
void inchidere_operatie()
{
    readimagefile("Operatii/Inchidere_operatie.jpg",afopx,afopy,afopxx,afopyy);
}
void op_Adaugare_prim_nod()
{
    readimagefile("Operatii/Adaugare_prim_nod.jpg",afopx,afopy,afopxx,afopyy);  // Cand prim == NULL
    delay(animatie);
}
void op_Stergere_prim_nod()
{
    readimagefile("Operatii/Stergere_prim_nod.jpg",afopx,afopy,afopxx,afopyy); // Cand prim == NULL
    delay(animatie);
}
void op_Adaugare_nod_la_inceput()
{
    readimagefile("Operatii/Adaugare_nod_la_inceput.jpg",afopx,afopy,afopxx,afopyy);
    delay(animatie);
}
void op_Adaugare_nod_la_sfarsit()
{
    readimagefile("Operatii/Adaugare_nod_la_sfarsit.jpg",afopx,afopy,afopxx,afopyy);
    delay(animatie);
}
void op_Adaugare_nod_pe_pozitie()
{
    readimagefile("Operatii/Adaugare_nod_pe_pozitie.jpg",afopx,afopy,afopxx,afopyy);
    delay(animatie);
}

void op_Stergere_de_pe_pozitie()
{
    readimagefile("Operatii/Stergere_de_pe_pozitie.jpg",afopx,afopy,afopxx,afopyy);
    delay(animatie);
}
void op_Stergere_nod_inceput()
{
    readimagefile("Operatii/Stergere_nod_inceput.jpg",afopx,afopy,afopxx,afopyy);
    delay(animatie);
}
void op_Stergere_nod_sfarsit()
{
    readimagefile("Operatii/Stergere_nod_sfarsit.jpg",afopx,afopy,afopxx,afopyy);
    delay(animatie);
}
void op_Stergere_lista_after_clear()
{
    readimagefile("Operatii/Stergere_lista_after_clear.jpg",afopx,afopy,afopxx,afopyy);
    delay(animatie);
}
void viz_operatii_buton(bool afisare_operatii)
{
    if(afisare_operatii == true)
        readimagefile("Operatii/Vizualizare_operatii_on.jpg",vopx,vopy,vopxx,vopyy);
    else
        readimagefile("Operatii/Vizualizare_operatii_off.jpg",vopx,vopy,vopxx,vopyy);
}
void viz_op_on_off(bool & afisare_operatii)
{
    if(afisare_operatii == false)
    {
        afisare_operatii = true;
        readimagefile("Operatii/Vizualizare_operatii_on.jpg",vopx,vopy,vopxx,vopyy);
    }
    else
    {
        afisare_operatii = false;
        readimagefile("Operatii/Vizualizare_operatii_off.jpg",vopx,vopy,vopxx,vopyy);
    }

}
void stergere_noduri_after_clear(nod * & prim,nod * & ultim)
{
    nod* p;
    while(prim != NULL)
    {
        p = prim->next;
        delete prim;
        prim = p;
    }
    prim = NULL;
    ultim = NULL;
}

void inserare_la_inceput(nod * & prim,nod * & ultim, int &count_noduri,int valoare)
{
    if(count_noduri == 0)
    {
        nod * temp = new nod;
        temp->info = valoare;
        prim = temp;
        ultim = temp;
        count_noduri++;
    }
    else
    {
        nod * temp = new nod;
        temp->info = valoare;
        temp -> next = prim;
        nod *p = prim;
        prim = temp;
        while(p != ultim)
        {
            p = p->next;
        }
        ultim = p;
        ultim -> next = NULL;
        count_noduri++;

    }

}

void inserare_pozitie(nod * & prim,nod * & ultim,int & count_noduri,int valoare,int pozitie)  // E stricata ...
{
    if(prim == NULL && pozitie == 1)
    {
        nod * temp = new nod;
        temp->info = valoare;
        prim = temp;
        ultim = temp;
        count_noduri++;
    }
    else if(pozitie == 1)
    {
        nod * temp = new nod;
        temp->info = valoare;
        count_noduri++;
        temp->next = prim;
        prim = temp;
    }
    else if(pozitie <= count_noduri+1 && pozitie > 1)
    {

        nod * temp = new nod;
        temp->info = valoare;
        count_noduri++;
        nod * p = prim;
        nod * curent = prim;
        int iter = 1;

        while(iter < pozitie)
        {
            curent = p;
            p = p->next;
            iter++;
        }
        curent -> next = temp;
        temp->next = p;
        while(curent -> next != NULL)
            curent = curent ->next;
        ultim = curent;
        ultim -> next == NULL;

    }
    else
    {
        eroare_nu_exista_element_pe_pozitia_introdusa();
    }

}

void stergerea_primului_element(nod *& prim,nod *& ultim,int & count_noduri)
{
    if(count_noduri > 0)
    {
        if(count_noduri == 1)
        {
            delete prim;
            count_noduri--;
            ultim = NULL;
            prim = NULL;
        }
        else
        {
            nod * p = prim->next;
            delete prim;
            prim = p;
            count_noduri--;

        }
        cleardevice();
        viz_operatii_buton(afisare_operatii);

    }
    else if(count_noduri == 0)
        eroare_nu_exista_noduri_pentru_stergere();
}


void Stergere_ultim_nod(nod* &prim, nod*& ultim, int & count_noduri)
{
    if(count_noduri > 0)
    {
        if(count_noduri == 1)
        {
            delete prim;
            count_noduri--;
            ultim = NULL;
            prim = NULL;
        }
        else
        {
            nod*p;
            nod*curent;
            p = prim;
            curent = prim;
            while(p->next != NULL)
            {
                curent = p;
                p = p->next;

            }
            nod * temp;
            temp = ultim;
            ultim = curent;
            delete temp;
            ultim->next = NULL;
            count_noduri--;
        }
        cleardevice();
        viz_operatii_buton(afisare_operatii);
    }
}

void stergerea_de_pe_pozitie(nod * & prim, nod * & ultim,int pozitie)
{
    if(count_noduri > 0)
    {
        nod * p = prim;
        nod * curent = prim;
        if(count_noduri == 1 && pozitie == 1)
        {
            delete prim;
            count_noduri--;
            ultim = NULL;
            prim = NULL;
        }
        else if(pozitie == 1 && p->next != NULL)
        {
            p = prim -> next;
            delete prim;
            count_noduri--;
            prim = p;
        }
        else if(pozitie<count_noduri)
        {

            int iter = 1;

            while(iter<pozitie)
            {
                curent = p;
                p = p->next;
                iter++;
            }
            curent->next = p->next;
            delete p;
            count_noduri--;
        }
        else if(pozitie == count_noduri)
        {
            int iter = 1;

            while(iter<pozitie)
            {
                curent = p;
                p = p -> next;
                iter++;
            }
            delete p;
            ultim = curent;
            ultim -> next = NULL;
            count_noduri--;
        }
        else if(pozitie > count_noduri)
            eroare_nu_exista_element_pe_pozitia_introdusa();
    }
    else if(count_noduri == 0)
        eroare_nu_exista_noduri_pentru_stergere();


}


int marimeText_Liste(char str[],int lungime,int inaltime)   // Functie implementata de Dodan Gabriel pentru redimensionarea textului in interiorul unui dreptunghi
{
    int textsize=20;
    settextstyle(0,0,textsize);
    while (textwidth(str)>lungime||textheight(str)>inaltime)
    {
        textsize--;
        settextstyle(0,0,textsize);
    }
    return textsize;
}

/**
int valoare;
int pozitie;
int deplasare_cifra = Latime/59;
char numar[2];
char bar_count[1];

int valoarex = Latime/1.588877;

void coordonate_valoare_init(int &valoarex)
{
    valoarex =  Latime/1.588877;
}
*/
void deplasare_valoare(int & valoarex)
{
    valoarex += deplasare_cifra;
}
void deplasare_valoare_inapoi(int & valoarex)
{
    valoarex -= deplasare_cifra;
}
void transformare_valoare_int(char numar[3],int & valoare)
{
    int formare_numar = 0;
    for(int i = 0; i<strlen(numar); i++)
    {
        formare_numar = formare_numar*10+numar[i]-'0';
        /*if(isdigit(numar[i]))
        formare_numar = int(numar[i]+'0') * 10;
        cout<<formare_numar<<" ";
        */
    }
    valoare = formare_numar;
    // cout<<endl<<valoare<<endl;
}
void transformare_pozitie_int(char poz[2],int & pozitie)
{
    int formare_pozitie = 0;
    for(int i = 0; i<strlen(poz); i++)
        formare_pozitie = formare_pozitie * 10 + poz[i]-'0';
    pozitie = formare_pozitie;
}
void transformareText_Liste(char str[], int valoare)            // functie care transforma un numar in sir de caractere
{
    strcpy(str,"   ");
    int k=0;
    int aux = valoare;
    while (aux!= 0)
    {
        k++;
        aux=aux/10;
    }
    while (valoare!=0)
    {
        str[k-1]=valoare%10+'0';
        k--;
        valoare = valoare/10;
    }
}

void transformareTextcount_Liste(char str[], int valoare)
{
    strcpy(str,"  ");
    int k=0;
    int aux = valoare;
    while (aux!= 0)
    {
        k++;
        aux=aux/10;
    }
    while (valoare!=0)
    {
        str[k-1]=valoare%10+'0';
        k--;
        valoare = valoare/10;
    }
}

char poz[1];

void introduceti_o_pozitie(int & pozitie, char poz[2])
{
    int i = strlen(poz);
    coordonate_valoare_init(valoarex);
    setcolor(COLOR(255,60,0));
    setbkcolor(COLOR(0,135,253));
    char str[] = " ";
    int a = 0;
    int nrcf = 1;
    readimagefile("Erori/Introduceti_pozitie.jpg",Latime/2.188782,Lungime/5.095541,Latime/1.60642,Lungime/4.44);
    while(kbhit())
        getch();
    while((a = getch()))
    {
        if(a==8)
        {
            if(i >= 0 && poz[0] != NULL)
            {
                //bar(Latime/1.588877,Lungime/5.26315789,Latime/1.461187,Lungime/4.1025641);
                deplasare_valoare_inapoi(valoarex);
                i--;
                poz[i] = NULL;
                nrcf--;
                setfillstyle(SOLID_FILL,COLOR(0,135,253));
                bar(valoarex,Lungime/5.26315789,Latime/1.461187,Lungime/4.1025641);
            }

        }
        else if(a!=13)
        {
            if(nrcf<=2 && isdigit(a))
            {
                if(i <= 1)
                    i++;
                str[0] = char(a);
                nrcf++;
                strcat(poz,str);
                settextstyle(0,0,marimeText_Liste(str,Latime/17.977528,Lungime/18.18));
                outtextxy(valoarex,Lungime/5.26315789,str);
                deplasare_valoare(valoarex);
            }
            else if(nrcf>2)
            {
                eroare_ati_depasit_limita_de_cifre();
            }
            else if(!isdigit(a))
                eroare_trebuie_introduse_doar_cifre();


        }


        else if(isdigit(str[0]))
        {
            readimagefile("Erori/Inchidere Introduceti_valoare.jpg",Latime/2.188782,Lungime/5.095541,Latime/1.60642,Lungime/4.44);
            clearmouseclick(WM_LBUTTONDOWN);
            break;
        }
    }
    transformare_pozitie_int(poz,pozitie);
    setcolor(BLACK);
}

void introduceti_o_valoare(int & valoare,char numar[3])
{
    int j = strlen(numar);
    coordonate_valoare_init(valoarex);
    setcolor(COLOR(255,60,0));
    setbkcolor(COLOR(0,135,253));
    char str[] = " ";
    int a = 0;
    int nrcf = 1;
    readimagefile("Erori/Introduceti_valoare.jpg",Latime/2.188782,Lungime/5.095541,Latime/1.60642,Lungime/4.44);
    while(kbhit())
        getch();
    while((a = getch()))
    {
        if(a==8)
        {
            if(j >= 0 && numar[0] != NULL)
            {
                deplasare_valoare_inapoi(valoarex);
                j--;
                numar[j] = NULL;
                nrcf--;
                setfillstyle(SOLID_FILL,COLOR(0,135,253));
                bar(valoarex,Lungime/5.26315789,Latime/1.461187,Lungime/4.1025641);
            }

        }
        else if(a!=13)
        {
            if(nrcf<=3 && isdigit(a))
            {
                if(j <= 2)
                    j++;
                str[0] = char(a);
                nrcf++;
                strcat(numar,str);
                settextstyle(0,0,marimeText_Liste(str,Latime/17.977528,Lungime/18.18));
                outtextxy(valoarex,Lungime/5.26315789,str);
                deplasare_valoare(valoarex);
            }
            else if(nrcf>3)
            {
                eroare_ati_depasit_limita_de_cifre();
            }
            else if(!isdigit(a))
                eroare_trebuie_introduse_doar_cifre();


        }


        else if(isdigit(str[0]))
        {
            readimagefile("Erori/Inchidere Introduceti_valoare.jpg",Latime/2.188782,Lungime/5.095541,Latime/1.60642,Lungime/4.44);
            clearmouseclick(WM_LBUTTONDOWN);
            break;
        }
    }
    transformare_valoare_int(numar,valoare);
    setcolor(BLACK);
}



void afisare_all_info_in_casute(nod* prim, int count_noduri)
{
    nod * p = prim;
    coordonate_casuta_valori_dreapta_init(valdx,valdy,valdxx,valdyy);
    coordonate_casuta_valori_stanga_init(valsx,valsy,valsxx,valsyy);
    coordonate_bar_count_noduri_dreapta_init(cndx,cndy,cndxx,cndyy);
    coordonate_bar_count_noduri_stanga_init(cnsx,cnsy,cnsxx,cnsyy);
    int poz = 1 ;
    int val,i;
    int impartire = 1;
    while(poz <= count_noduri && p != NULL)
    {
        val = 0;
        impartire = 1;
        setbkcolor(COLOR(6,161,254));
        setcolor(RED);
        strcpy(bar_count,"  ");
        if(poz <= 6 && poz <= count_noduri)
        {
            strcpy(numar,"   ");

            transformareText_Liste(numar,p->info);
            settextstyle(0,0,marimeText_Liste(numar,Latime/26.6,Lungime/22.8571428));
            outtextxy(valdx,valdy,numar);
            transformareTextcount_Liste(bar_count,poz);
            settextstyle(0,0,marimeText_Liste(bar_count,Latime/57.142857,Lungime/27.586206));
            setcolor(BLACK);
            outtextxy(cndx,cndy,bar_count);


            deplasare_coordonate_casuta_valori_dreapta(valdx,valdxx);
            deplasare_bar_count_noduri_dreapta(cndx,cndxx);
            p = p -> next;

            poz++;

        }
        else if(poz > 6 && poz <= 12 && poz <= count_noduri)
        {

            strcpy(numar,"   ");

            transformareText_Liste(numar,p->info);
            settextstyle(0,0,marimeText_Liste(numar,Latime/26.6,Lungime/22.8571428));
            outtextxy(valsx,valsy,numar);
            transformareTextcount_Liste(bar_count,poz);
            setcolor(BLACK);
            settextstyle(0,0,marimeText_Liste(bar_count,Latime/57.142857,Lungime/27.586206));
            outtextxy(cnsx,cnsy,bar_count);


            deplasare_coordonate_casuta_valori_stanga(valsx,valsxx);
            deplasare_bar_count_noduri_stanga(cnsx,cnsxx);
            p = p -> next;

            poz++;
            if(poz == 13)
            {
                coordonate_casuta_valori_dreapta_init(valdx,valdy,valdxx,valdyy);
                deplasare_coordonate_casuta_valori_dreapta_jos(valdy,valdyy);
                coordonate_bar_count_noduri_dreapta_init(cndx,cndy,cndxx,cndyy);
                deplasare_bar_count_noduri_dreapta_jos(cndy,cndyy);

            }
        }
        else if(poz > 12 && poz <= 18 && poz <= count_noduri)
        {

            strcpy(numar,"   ");

            transformareText_Liste(numar,p->info);
            settextstyle(0,0,marimeText_Liste(numar,Latime/26.6,Lungime/22.8571428));
            outtextxy(valdx,valdy,numar);
            transformareTextcount_Liste(bar_count,poz);
            setcolor(BLACK);
            settextstyle(0,0,marimeText_Liste(bar_count,Latime/57.142857,Lungime/27.586206));
            outtextxy(cndx,cndy,bar_count);


            deplasare_coordonate_casuta_valori_dreapta(valdx,valdxx);
            deplasare_bar_count_noduri_dreapta(cndx,cndxx);
            p = p -> next;

            poz++;
            if(poz == 19)
            {
                coordonate_casuta_valori_stanga_init(valsx,valsy,valsxx,valsyy);
                deplasare_coodronate_casuta_valori_stanga_jos(valsy,valsyy);
                coordonate_bar_count_noduri_stanga_init(cnsx,cnsy,cnsxx,cnsyy);
                deplasare_bar_count_noduri_stanga_jos(cnsy,cnsyy);

            }
        }
        else if(poz > 18 && poz <= 24 && poz <= count_noduri)
        {

            strcpy(numar,"   ");
            transformareText_Liste(numar,p->info);
            settextstyle(0,0,marimeText_Liste(numar,Latime/26.6,Lungime/22.8571428));
            outtextxy(valsx,valsy,numar);
            transformareTextcount_Liste(bar_count,poz);
            setcolor(BLACK);
            settextstyle(0,0,marimeText_Liste(bar_count,Latime/57.142857,Lungime/27.586206));
            outtextxy(cnsx,cnsy,bar_count);


            deplasare_coordonate_casuta_valori_stanga(valsx,valsxx);
            deplasare_bar_count_noduri_stanga(cnsx,cnsxx);
            p = p -> next;

            poz++;
        }

    }
}

void afisare_noduri_after_stergere_sfarsit(nod*prim, bool & stanga, bool & dreapta)
{
    if(count_noduri == 0)
    {
        readimagefile("JPG/Listesimple.jpg",0,0,Latime,Lungime);
        deschidere_meniu_functii(deschis);
        viz_operatii_buton(afisare_operatii);
    }
    else if(prim==NULL && count_noduri > 0)
    {

        readimagefile("JPG/main_Lista_simpla_head.jpg",0,0,Latime,Lungime);
        setcolor(BLACK);
        //setlinestyle(SOLID_LINE,SOLID_FILL,4);
        coordonate_img_nod_initial(nx,nxx,ny,nyy);
        readimagefile("JPG/Liste_simple_sageata_dreapta.jpg",nx,ny,nxx,nyy);
        reinitializare_deschis(deschis);
        deschidere_meniu_functii(deschis);
        line(sx,sy,sxx,syy);
        line(sxx,syy,vxx,vyy1);
        line(sxx,syy,vxx,vyy2);
        deplasare_sageata_dreapta(sx,sxx,vxx);
        nx+=deplasare_nod;
        nxx+=deplasare_nod;
        viz_operatii_buton(afisare_operatii);

    }
    else
    {
        if(dreapta==true)
        {
            deplasare_nod_dreapta(nx,ny,nxx,nyy,stanga,dreapta);
            //cout<<"dreapta"<<endl;
        }

        else if(stanga==true)
        {
            deplasare_nod_stanga(nx,ny,nxx,nyy,stanga,dreapta,capat);
            // cout<<"stanga"<<endl;
        }
    }
}

void Reconstruire_noduri_after_stergere_sfarsit(nod * prim)
{
    if(prim == NULL) // Cand nu mai este niciun nod se afiseaza background ul initial
    {
        readimagefile("JPG/Listesimple.jpg",0,0,Latime,Lungime);
        deschidere_meniu_functii(deschis);
        viz_operatii_buton(afisare_operatii);
    }
    else
    {
        nod * p;
        p = prim;
        afisare_noduri_after_stergere_sfarsit(NULL,stanga,dreapta); // afiseaza primul nod grafic
        while(p->next!=NULL && prim != NULL)
        {
            p = p->next;
            afisare_noduri_after_stergere_sfarsit(p,stanga,dreapta); // afiseaza restul nodurilor grafic
        }
    }



}

void evidentiere_buton_inserare_inceput()
{
    readimagefile("Evidentiatoare/Inserare la inceputul listei.jpg",xi,yi,xxi,yyi);

}
void revenire_buton_inserare_inceput()
{
    readimagefile("Butoane/Inserare la inceputul listei.jpg",xi,yi,xxi,yyi);
}

void evidentiere_buton_inserare_pozitie()
{
    readimagefile("Evidentiatoare/Inserare pe o anumita pozitie.jpg",ipx,ipy,ipxx,ipyy);
}
void revenire_buton_inserare_pozitie()
{
    readimagefile("Butoane/Inserare pe o anumita pozitie.jpg",ipx,ipy,ipxx,ipyy);
}

void evidentiere_buton_stergere_inceput()
{
    readimagefile("Evidentiatoare/Stergerea primului element din lista.jpg",six,siy,sixx,siyy);
}

void revenire_buton_stergere_inceput()
{
    readimagefile("Butoane/Stergerea primului element din lista.jpg",six,siy,sixx,siyy);
}
void evidentiere_buton_stergere_sfarsit()
{
    readimagefile("Evidentiatoare/Stergerea unui element de la sfarsitul listei.jpg",sfx,sfy,sfxx,sfyy);
}
void revenire_buton_stergere_sfarsit()
{
    readimagefile("Butoane/Stergerea unui element de la sfarsitul listei.jpg",sfx,sfy,sfxx,sfyy);

}


void evidentiere_buton_stergere_pozitie()
{
    readimagefile("Evidentiatoare/Stergerea unui element de pe o anumita pozitie.jpg",spx,spy,spxx,spyy);
}
void revenire_buton_stergere_pozitie()
{
    readimagefile("Butoane/Stergerea unui element de pe o anumita pozitie.jpg",spx,spy,spxx,spyy);
}
void evidentiere_buton_salveaza_lista()
{
    readimagefile("Evidentiatoare/Salveaza lista.jpg",savex,savey,savexx,saveyy);
}
void revenire_buton_salveaza_lista()
{
    readimagefile("Butoane/Salveaza lista.jpg",savex,savey,savexx,saveyy);
}


void rezolvaListeSimple(bool & mainlistesimple, bool & mainliste)
{
    readimagefile("JPG/Listesimple.jpg",0,0,x,y);
    coordonate_buton_Liste();
    coordonate_buton_Liste_simple();
    coordonate_buton_Adauga_nod();
    coordonate_buton_clear();
    coordonate_buton_back_meniu_liste();
    coordonate_buton_functii();
    coordonate_buton_inserare_inceput();
    coordonate_inserare_pozitie();
    coordonate_stergere_inceput();
    coordonate_buton_stergere_sfarsit();
    coordonate_stergere_pozitie();
    coordonate_salveaza_lista();
    coordonate_buton_vizualizare_operatii();
    bool evidentiere_on = 0;
    while(mainlistesimple == true)
    {
        if(mousex() >= xf && mousex() <= xx && mousey() >= yf && mousey()<= yy && deschis == true)
        {

            if(mousex() >= xi && mousex() <= xxi && mousey() >= yi && mousey()<= yyi )
                evidentiere_buton_inserare_inceput();
            else
                revenire_buton_inserare_inceput();
            if(mousex()>= ipx && mousex()<= ipxx && mousey()>= ipy && mousey()<= ipyy )
                evidentiere_buton_inserare_pozitie();
            else
                revenire_buton_inserare_pozitie();
            if(mousex()>= six && mousex()<= sixx && mousey()>= siy && mousey()<= siyy )
                evidentiere_buton_stergere_inceput();
            else
                revenire_buton_stergere_inceput();
            if(mousex() >= sfx && mousex() <= sfxx && mousey() >= sfy && mousey()<= sfyy )
                evidentiere_buton_stergere_sfarsit();
            else
                revenire_buton_stergere_sfarsit();
            if(mousex()>= spx && mousex()<= spxx && mousey()>= spy && mousey()<= spyy  )
                evidentiere_buton_stergere_pozitie();
            else
                revenire_buton_stergere_pozitie();
            if(mousex()>= savex && mousex()<= savexx && mousey()>= savey && mousey()<= saveyy )
                evidentiere_buton_salveaza_lista();
            else
                revenire_buton_salveaza_lista();
        }
        if(ismouseclick(WM_LBUTTONDOWN))
        {
            // BUTON Vizualizare operatii
            if(ismouseclick(WM_LBUTTONDOWN))
                if(mousex()>=coordonateVizualizareOperatii.x1 && mousex()<=coordonateVizualizareOperatii.x2 && mousey()>=coordonateVizualizareOperatii.y1 && mousey()<=coordonateVizualizareOperatii.y2)
                {
                    viz_op_on_off(afisare_operatii);
                    clearmouseclick(WM_LBUTTONDOWN);
                }
            // BUTON Adauga Nod
            if(ismouseclick(WM_LBUTTONDOWN))
                if(mousex()>=coordonateAdaugaNod.x1 && mousex()<=coordonateAdaugaNod.x2 && mousey()>=coordonateAdaugaNod.y1 && mousey()<=coordonateAdaugaNod.y2)
                {
                    clearmouseclick(WM_LBUTTONDOWN);
                    if(capat == false)
                    {
                        strcpy(numar,"");
                        introduceti_o_valoare(valoare,numar);
                        setfillstyle(SOLID_FILL,COLOR(0,135,253));
                        bar(Latime/1.588877,Lungime/5.26315789,Latime/1.467889,Lungime/4.1025641);
                        if(afisare_operatii == true)
                        {
                            if(prim == NULL)
                            {
                                op_Adaugare_prim_nod();
                                inchidere_operatie();
                            }
                            else
                            {
                                op_Adaugare_nod_la_sfarsit();
                                inchidere_operatie();
                            }
                        }
                        adaugare_nod_la_sfarsit(prim,ultim,valoare,count_noduri);
                        afisare_all_info_in_casute(prim,count_noduri);
                        coordonate_valoare_init(valoarex);
                        readimagefile("Erori/Inchidere Introduceti_valoare.jpg",Latime/2.188782,Lungime/4.93827,Latime/1.60642,Lungime/4.4);

                        viz_operatii_buton(afisare_operatii);
                    }
                    else eroare_limita_noduri();
                    clearmouseclick(WM_LBUTTONDOWN);
                }
            // BUTON Clear
            if(ismouseclick(WM_LBUTTONDOWN))
                if(mousex()>=coordonateClear.x1 && mousex()<= coordonateClear.x2 && mousey()>=coordonateClear.y1 && mousey()<=coordonateClear.y2)
                {
                    cleardevice();
                    setcolor(BLACK);
                    readimagefile("JPG/Listesimple.jpg",0,0,Latime,Lungime);
                    coordonate_img_nod_initial(nx,nxx,ny,nyy);
                    stergere_noduri_after_clear(prim,ultim);
                    coordonate_sageata_dreapta_init(sx,sxx,sy,syy);
                    coordonate_varf_sageata_dreapta_init(vxx,vyy1,vyy2);
                    coordonate_sageata_stanga_init(stgx,stgy,stgxx,stgyy);
                    coordonate_varf_sageata_stanga_init(vstgxx,vstgyy1,vstgyy2);
                    coordonate_sageata_jos_dreapta_init(sdx,sdy,sdxx,sdyy,sdxx1,sdyy1,sdxx2);
                    coordonate_sageata_jos_stanga_init(sgstgx,sgstgy,sgstgxx,sgstgyy,sgstgxx1,sgstgyy1,sgstgxx2);
                    init_capat(capat);
                    reinitializare_deschis(deschis);
                    reinitializare_count_noduri(count_noduri);
                    stanga = false;
                    dreapta = true;
                    viz_operatii_buton(afisare_operatii);
                    clearmouseclick(WM_LBUTTONDOWN);
                    if(afisare_operatii == true)
                    {
                        op_Stergere_lista_after_clear();
                        inchidere_operatie();
                    }


                }
            ///BUTON Back
            if(ismouseclick(WM_LBUTTONDOWN))
                if(mousex()>=coordonatebutonback.x1 && mousex()<=coordonatebutonback.x2 && mousey()>=coordonatebutonback.y1 && mousey()<=coordonatebutonback.y2)
                {
                    mainliste = true;
                    mainlistesimple = false;
                    stergere_noduri_after_clear(prim,ultim);
                    coordonate_img_nod_initial(nx,nxx,ny,nyy);
                    reinitializare_stanga_dreapta(stanga,dreapta);
                    coordonate_sageata_dreapta_init(sx,sxx,sy,syy);
                    coordonate_varf_sageata_dreapta_init(vxx,vyy1,vyy2);
                    coordonate_sageata_stanga_init(stgx,stgy,stgxx,stgyy);
                    coordonate_varf_sageata_stanga_init(vstgxx,vstgyy1,vstgyy2);
                    coordonate_sageata_jos_dreapta_init(sdx,sdy,sdxx,sdyy,sdxx1,sdyy1,sdxx2);
                    coordonate_sageata_jos_stanga_init(sgstgx,sgstgy,sgstgxx,sgstgyy,sgstgxx1,sgstgyy1,sgstgxx2);
                    reinitializare_count_noduri(count_noduri);
                    init_capat(capat);
                    cleardevice();
                    reinitializare_buton_viz_op(afisare_operatii);
                    readimagefile("JPG/main_Liste.jpg",0,0,Latime,Lungime);
                    reinitializare_deschis(deschis);
                    clearmouseclick(WM_LBUTTONDOWN);

                }
            // BUTON Functii
            if(mousex()>=coordonateFunctii.x1 && mousex()<= coordonateFunctii.x2 && mousey()>=coordonateFunctii.y1 && mousey()<=coordonateFunctii.y2)
            {
                deschidere_meniu_functii(deschis);

            }
            // BUTON Functii -> Stergere element de la sfarsit
            if(ismouseclick(WM_LBUTTONDOWN))
                if(mousex()>=coordonatebutonStergereSfarsit.x1 && mousex()<= coordonatebutonStergereSfarsit.x2 && mousey()>=coordonatebutonStergereSfarsit.y1 && mousey()<=coordonatebutonStergereSfarsit.y2 && deschis == true)
                {
                    if(prim != NULL)
                    {
                        if(prim->next == NULL && afisare_operatii == true)
                        {
                            op_Stergere_prim_nod();
                            inchidere_operatie();
                        }
                        else if(prim -> next != NULL && afisare_operatii == true)
                        {
                            op_Stergere_nod_sfarsit();
                            inchidere_operatie();
                        }
                        Stergere_ultim_nod(prim,ultim,count_noduri);
                        coordonate_img_nod_initial(nx,nxx,ny,nyy);
                        reinitializare_stanga_dreapta(stanga,dreapta);
                        coordonate_sageata_dreapta_init(sx,sxx,sy,syy);
                        coordonate_varf_sageata_dreapta_init(vxx,vyy1,vyy2);
                        coordonate_sageata_stanga_init(stgx,stgy,stgxx,stgyy);
                        coordonate_varf_sageata_stanga_init(vstgxx,vstgyy1,vstgyy2);
                        coordonate_sageata_jos_dreapta_init(sdx,sdy,sdxx,sdyy,sdxx1,sdyy1,sdxx2);
                        coordonate_sageata_jos_stanga_init(sgstgx,sgstgy,sgstgxx,sgstgyy,sgstgxx1,sgstgyy1,sgstgxx2);
                        Reconstruire_noduri_after_stergere_sfarsit(prim);
                        afisare_all_info_in_casute(prim,count_noduri);
                        init_capat(capat);
                    }
                    else
                        eroare_nu_exista_noduri_pentru_stergere();
                    clearmouseclick(WM_LBUTTONDOWN);
                }
            // BUTON Functii -> Inserare element la inceput
            if(ismouseclick(WM_LBUTTONDOWN))
                if(mousex()>=coordonateInserareInceput.x1 && mousex()<= coordonateInserareInceput.x2 && mousey()>=coordonateInserareInceput.y1 && mousey()<=coordonateInserareInceput.y2 && deschis == true)
                {
                    if(capat == true)
                        eroare_limita_noduri();
                    else
                    {
                        setlinestyle(0,0,2);
                        strcpy(numar,"");
                        introduceti_o_valoare(valoare,numar);
                        setfillstyle(SOLID_FILL,COLOR(0,135,253));
                        bar(Latime/1.588877,Lungime/5.26315789,Latime/1.467889,Lungime/4.1025641);
                        if(count_noduri == 0)
                        {
                            setcolor(BLACK);
                            readimagefile("JPG/main_Lista_simpla_head.jpg",0,0,Latime,Lungime);
                            viz_operatii_buton(afisare_operatii);
                            if(afisare_operatii == true)
                            {
                                op_Adaugare_prim_nod();
                                inchidere_operatie();
                            }
                        }
                        if(prim != NULL && afisare_operatii == true)
                        {
                            op_Adaugare_nod_la_inceput();
                            inchidere_operatie();
                        }
                        inserare_la_inceput(prim,ultim,count_noduri,valoare);
                        afisare_noduri_after_stergere_sfarsit(prim,stanga,dreapta);
                        afisare_all_info_in_casute(prim,count_noduri);
                        reinitializare_deschis(deschis);
                        deschidere_meniu_functii(deschis);
                        viz_operatii_buton(afisare_operatii);
                    }
                    clearmouseclick(WM_LBUTTONDOWN);
                }
            // BUTON Functii -> Inserare element pe o anumita pozitie
            if(ismouseclick(WM_LBUTTONDOWN))
                if(mousex()>=coordonateInserarepozitie.x1 && mousex()<= coordonateInserarepozitie.x2 && mousey()>=coordonateInserarepozitie.y1 && mousey()<=coordonateInserarepozitie.y2 && deschis == true)
                {
                    if(capat == true)
                        eroare_limita_noduri();
                    else
                    {
                        setlinestyle(0,0,2);
                        if(count_noduri == 0)
                        {
                            setcolor(BLACK);
                            readimagefile("JPG/main_Lista_simpla_head.jpg",0,0,Latime,Lungime);
                            deschidere_meniu_functii(deschis);
                            viz_operatii_buton(afisare_operatii);
                        }
                        strcpy(poz,"");
                        strcpy(numar,"");
                        introduceti_o_pozitie(pozitie,poz);
                        setfillstyle(SOLID_FILL,COLOR(0,135,253));
                        bar(Latime/1.588877,Lungime/5.26315789,Latime/1.467889,Lungime/4.1025641);
                        if(pozitie > count_noduri+1 || pozitie == 0)
                            eroare_nu_exista_element_pe_pozitia_introdusa();  // pozitia este gresita
                        else
                        {
                            introduceti_o_valoare(valoare,numar);
                            setfillstyle(SOLID_FILL,COLOR(0,135,253));
                            bar(Latime/1.588877,Lungime/5.26315789,Latime/1.467889,Lungime/4.1025641);
                            if(afisare_operatii==true && prim == NULL && pozitie == 1)
                            {
                                op_Adaugare_prim_nod();
                                inchidere_operatie();
                            }
                            if(afisare_operatii == true && prim != NULL && pozitie == 1)
                            {
                                op_Adaugare_nod_la_inceput();
                                inchidere_operatie();
                            }
                            if(afisare_operatii== true && pozitie != 1)
                            {
                                op_Adaugare_nod_pe_pozitie();
                                inchidere_operatie();
                            }
                            inserare_pozitie(prim,ultim,count_noduri,valoare,pozitie);
                            afisare_noduri_after_stergere_sfarsit(prim,stanga,dreapta);
                            afisare_all_info_in_casute(prim,count_noduri);
                        }
                    }
                    clearmouseclick(WM_LBUTTONDOWN);
                }
            // BUTON Functii -> Stergerea primului element
            if(ismouseclick(WM_LBUTTONDOWN))
                if(mousex()>=coordonateStergereinceput.x1 && mousex()<= coordonateStergereinceput.x2 && mousey()>=coordonateStergereinceput.y1 && mousey()<=coordonateStergereinceput.y2 && deschis == true)
                {
                    if(prim != NULL)
                    {
                        if(prim->next == NULL && afisare_operatii == true)
                        {
                            op_Stergere_prim_nod();
                            inchidere_operatie();
                        }
                        if(prim->next != NULL && afisare_operatii == true)
                        {
                            op_Stergere_nod_inceput();
                            inchidere_operatie();
                        }
                        stergerea_primului_element(prim,ultim,count_noduri);
                        coordonate_img_nod_initial(nx,nxx,ny,nyy);
                        reinitializare_stanga_dreapta(stanga,dreapta);
                        coordonate_sageata_dreapta_init(sx,sxx,sy,syy);
                        coordonate_varf_sageata_dreapta_init(vxx,vyy1,vyy2);
                        coordonate_sageata_stanga_init(stgx,stgy,stgxx,stgyy);
                        coordonate_varf_sageata_stanga_init(vstgxx,vstgyy1,vstgyy2);
                        coordonate_sageata_jos_dreapta_init(sdx,sdy,sdxx,sdyy,sdxx1,sdyy1,sdxx2);
                        coordonate_sageata_jos_stanga_init(sgstgx,sgstgy,sgstgxx,sgstgyy,sgstgxx1,sgstgyy1,sgstgxx2);
                        Reconstruire_noduri_after_stergere_sfarsit(prim);
                        afisare_all_info_in_casute(prim,count_noduri);
                    }
                    else
                        eroare_nu_exista_noduri_pentru_stergere();
                    clearmouseclick(WM_LBUTTONDOWN);
                }
            // BUTON Functii -> Stergerea de pe o anumita pozitie
            if(ismouseclick(WM_LBUTTONDOWN))
                if(mousex()>=coordonateStergerepozitie.x1 && mousex()<= coordonateStergerepozitie.x2 && mousey()>=coordonateStergerepozitie.y1 && mousey()<=coordonateStergerepozitie.y2 && deschis == true)
                {
                    if(prim != NULL)
                    {
                        strcpy(poz,"");
                        introduceti_o_pozitie(pozitie,poz);
                        setfillstyle(SOLID_FILL,COLOR(0,135,253));
                        bar(Latime/1.588877,Lungime/5.26315789,Latime/1.467889,Lungime/4.1025641);
                        if(pozitie == 1 && prim -> next == NULL && afisare_operatii == true)
                        {
                            op_Stergere_prim_nod();
                            inchidere_operatie();
                        }
                        if(pozitie == 1 && prim -> next != NULL && afisare_operatii == true)
                        {
                            op_Stergere_nod_inceput();
                            inchidere_operatie();
                        }
                        if(pozitie != 1 && pozitie <= count_noduri && afisare_operatii == true)
                        {
                            op_Stergere_de_pe_pozitie();
                            inchidere_operatie();
                        }
                        stergerea_de_pe_pozitie(prim,ultim,pozitie);
                        coordonate_img_nod_initial(nx,nxx,ny,nyy);
                        reinitializare_stanga_dreapta(stanga,dreapta);
                        coordonate_sageata_dreapta_init(sx,sxx,sy,syy);
                        coordonate_varf_sageata_dreapta_init(vxx,vyy1,vyy2);
                        coordonate_sageata_stanga_init(stgx,stgy,stgxx,stgyy);
                        coordonate_varf_sageata_stanga_init(vstgxx,vstgyy1,vstgyy2);
                        coordonate_sageata_jos_dreapta_init(sdx,sdy,sdxx,sdyy,sdxx1,sdyy1,sdxx2);
                        coordonate_sageata_jos_stanga_init(sgstgx,sgstgy,sgstgxx,sgstgyy,sgstgxx1,sgstgyy1,sgstgxx2);
                        Reconstruire_noduri_after_stergere_sfarsit(prim);
                        afisare_all_info_in_casute(prim,count_noduri);
                    }
                    else
                        eroare_nu_exista_noduri_pentru_stergere();
                    clearmouseclick(WM_LBUTTONDOWN);
                }
            if(mousex()>=coordonateSalveazaLista.x1 && mousex()<= coordonateSalveazaLista.x2 && mousey()>=coordonateSalveazaLista.y1 && mousey()<=coordonateSalveazaLista.y2 && deschis == true)
            {
                if(prim != NULL)
                {
                    nod * temp;
                    temp = prim;
                    fout<<temp->info<<" ";
                    while(temp != ultim)
                    {
                        temp = temp->next;
                        fout<<temp->info<<" ";
                    }
                    fout<<"In total : "<<count_noduri<<" noduri" <<endl<<endl;
                }
                lista_a_fost_salvata();
                clearmouseclick(WM_LBUTTONDOWN);
            }
            clearmouseclick(WM_LBUTTONDOWN);
        }
        if(ismouseclick(WM_RBUTTONDOWN))
        {
            if(prim != NULL)
            {
                nod * temp;
                temp = prim;
                while(temp->next != ultim)
                    temp = temp->next;
            }
            clearmouseclick(WM_RBUTTONDOWN);
        }
    }
}
