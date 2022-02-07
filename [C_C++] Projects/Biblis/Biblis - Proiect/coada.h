#ifndef COADA_H_INCLUDED
#define COADA_H_INCLUDED

//----------------------------------------> Structura de date implementata de Dodan Gabriel <------------------------------------

#endif // COADA_H_INCLUDED

using namespace std;

ofstream f("coada.txt");

struct nodCoada {
    int info;
    nodCoada* next;
};
nodCoada * head, * tail ;

struct butonMeniuPrincipal_Coada
{
    int x1 = x/1.395;
    int x2 = x/1.05;
    int y1 = y/11.266;
    int y2 = y/3.97;
}coordonateMeniuPrincipal_Coada;

struct butonIntroducetiValoare_Coada
{
    int x1 = x/1.433;
    int x2 = x/1.04;
    int y1 = y/3.14;
    int y2 = y/2.73;

    int x3 = x/1.364;
    int x4 = x/1.104;
    int y3 = y/3.15;
    int y4 = y/2.397;
}coordonateIntroducetiValoare_Coada;

struct butonPush_Coada
{
    int x1 = x/1.35;
    int x2 = x/1.113;
    int y1 = y/2.048;
    int y2 = y/1.842;
}coordonatePush_Coada;

struct butonPop_Coada
{
    int x1 = x/1.333;
    int x2 = x/1.155;
    int y1 = y/1.609;
    int y2 = y/1.466;
}coordonatePop_Coada;

struct butonClear_Coada
{
    int x1 = x/1.7955;
    int x2 = x/1.4115;
    int y1 = y/1.6289;
    int y2 = y/1.4857;
}coordonateClear_Coada;

struct butonBack_Coada
{
    int x1 = x/11.6;
    int y1 = y/9.94;
}coordonateBack_Coada;

struct butonFisier_Coada
{
    int x1 = x/1.471;
    int y1 = 0;
    int x2 = x/1.0617;
    int y2 = y/22.5333;
    int x3 = x/1.3129;
    int y3 = y/22.5333;
    int x4 = x/1.1518;
    int y4 = y/12.29;
}coordonateFisier_Coada;

void ReinitCoords_queue()
{
    coordonateMeniuPrincipal_Coada.x1 = x/1.395;
    coordonateMeniuPrincipal_Coada.x2 = x/1.05;
    coordonateMeniuPrincipal_Coada.y1 = y/11.266;
    coordonateMeniuPrincipal_Coada.y2 = y/3.97;


    coordonateIntroducetiValoare_Coada.x1 = x/1.433;
    coordonateIntroducetiValoare_Coada.x2 = x/1.04;
    coordonateIntroducetiValoare_Coada.y1 = y/3.14;
    coordonateIntroducetiValoare_Coada.y2 = y/2.73;

    coordonateIntroducetiValoare_Coada.x3 = x/1.364;
    coordonateIntroducetiValoare_Coada.x4 = x/1.104;
    coordonateIntroducetiValoare_Coada.y3 = y/3.15;
    coordonateIntroducetiValoare_Coada.y4 = y/2.397;

    coordonatePush_Coada.x1 = x/1.35;
    coordonatePush_Coada.x2 = x/1.113;
    coordonatePush_Coada.y1 = y/2.048;
    coordonatePush_Coada.y2 = y/1.842;

    coordonatePop_Coada.x1 = x/1.333;
    coordonatePop_Coada.x2 = x/1.155;
    coordonatePop_Coada.y1 = y/1.609;
    coordonatePop_Coada.y2 = y/1.466;


    coordonateClear_Coada.x1 = x/1.7955;
    coordonateClear_Coada.x2 = x/1.4115;
    coordonateClear_Coada.y1 = y/1.6289;
    coordonateClear_Coada.y2 = y/1.4857;

    coordonateBack_Coada.x1 = x/11.6;
    coordonateBack_Coada.y1 = y/9.94;


    coordonateFisier_Coada.x1 = x/1.471;
    coordonateFisier_Coada.y1 = 0;
    coordonateFisier_Coada.x2 = x/1.0617;
    coordonateFisier_Coada.y2 = y/22.5333;
    coordonateFisier_Coada.x3 = x/1.3129;
    coordonateFisier_Coada.y3 = y/22.5333;
    coordonateFisier_Coada.x4 = x/1.1518;
    coordonateFisier_Coada.y4 = y/12.29;

}

bool isEmpty_Coada(nodCoada* head)
{
    return head == NULL;
}

void push_Coada(nodCoada*& head, nodCoada*& tail, int info)
{
    nodCoada* x = new nodCoada();
    x -> next = NULL;
    x -> info = info;
    if(tail != NULL)
        tail -> next = x;
    tail = x;
    if(head == NULL)
        head = x;
}



int pop_Coada(nodCoada*& head)
{
    if(isEmpty_Coada(head))
        return 0;
    nodCoada* curent = head;
    head = head -> next;
    int rezultat = curent -> info;
    delete curent;
    return rezultat;
}

int valoareFront(nodCoada* head)
{
    if(isEmpty_Coada(head))
        return 0;
    return head -> info;
}

int marimeText(char str[],int lungime,int inaltime)
{
    int textsize=40;
    settextstyle(0,0,textsize);
    while (textwidth(str)>lungime||textheight(str)>inaltime)
        {
            textsize--;
            settextstyle(0,0,textsize);
        }
    return textsize;
}

void apasatiEnter(int x, int y)
{
    char str[]="Apasati tasta enter";
    settextstyle(0,0,marimeText(str,x/2.5438-x/6.42632,50));
    outtextxy(x/2.2, y/7.193, str);
}

void eroareIsFull_Coada(int x, int y)
{
    char str[]="Eroare - coada este plina";
    setcolor(COLOR(200,100,50));
    settextstyle(0,0,marimeText(str,0.4*x,0.2*y));
    outtextxy(0.15*x,0.5*y,str);
    delay(1500);
    setcolor(COLOR(17,17,17));
    outtextxy(0.15*x,0.5*y,str);
}

void eroareIntroducetiValoare_Coada(int x, int y)
{
    setcolor(COLOR(200,100,50));
    setbkcolor(COLOR(17,17,17));
    char str[]="Introduceti o valoare";
    settextstyle(0,0,marimeText(str,0.4*x,0.2*y));
    outtextxy(0.15*x,0.5*y,str);
    delay(1000);
    setcolor(COLOR(17,17,17));
    outtextxy(0.15*x,0.5*y,str);
}

void eroareIsEmpty_Coada(int x, int y)
{
    setcolor(COLOR(200,100,50));;
    setbkcolor(COLOR(17,17,17));
    char str[]="Eroare - coada este goala";
    char strr[]="Introduceti o valoare";

    settextstyle(0,0,marimeText(str,0.4*x,0.2*y));
    outtextxy(0.15*x,0.5*y,str);
    outtextxy(0.17*x,0.55*y,strr);
    delay(1500);
    setcolor(COLOR(17,17,17));
    outtextxy(0.15*x,0.5*y,str);
    outtextxy(0.17*x,0.55*y,strr);

}

void popUpCoadaSalvata(int x, int y)
{
    setcolor(COLOR(200,100,50));
    setbkcolor(COLOR(17,17,17));
    char str[]="Coada a fost salvata in fisier";

    settextstyle(0,0,marimeText(str,0.4*x,0.2*y));
    outtextxy(0.15*x,0.5*y,str);
    setcolor(COLOR(17,17,17));
    delay(1500);
    outtextxy(0.15*x,0.5*y,str);
}

void apasatiPush_Coada(int x, int y)
{
    char str[]="Apasati butonul push";
    settextstyle(0,0,marimeText(str,x/2.5438-x/6.42632,50)); // TEXT APASATI BUTRONUL PUSH
    outtextxy(x/2.2, y/7.193, str);
}

void introducetiValoare_Coada(int x, int y,int &valoare, int k)
{

        while(kbhit()) getch();
        setcolor(COLOR(200,100,50));
        setbkcolor(COLOR(17,17,17));
        char str[] = "    ";
        int a=0;
        int i=-1;
        valoare = 0;
        while ((a = getch()))
        {

            if ((a >= '0' && a <= '9') || a == 13 || a == 8)
            {
                if (!(a == '0' && valoare == 0))
                {
                    setcolor(COLOR(200,100,50));
                    if (a == 8 ) // backspace
                    {
                        if(i>=0)
                        {
                            setfillstyle(SOLID_FILL,COLOR(17,17,17));
                            bar(x/1.45,y/3.19,x/1.034,y/2.33);
                            str[i]=' ';
                            valoare = valoare / 10;
                            outtextxy(0.79*x,0.365*y,str);
                            i--;
                        }
                    }
                    else
                        if (a != 13 )    // a=13 -- enter
                        {
                            if (i<2){
                            i++;
                            str[i] = char(a);
                            valoare = valoare*10+str[i]-'0';
                            }
                            if (i==2)
                            {
                                valoare = valoare / 10;
                                str[i] = char(a);
                                valoare = valoare*10+str[i]-'0';
                            }
                            str[i] = char(a);
                            bar(x/1.45,y/3.19,x/1.034,y/2.33);
                            settextstyle(0,0,marimeText(str,0.09*x,0.09*y));
                            outtextxy(0.79*x,0.365*y,str);
                        }else
                            if ( valoare != 0)
                                break;
                }
            }
        }

        setcolor(COLOR(200,100,50));
        apasatiPush_Coada(x,y);

}


void headAndTail(int x, int y)              // afiseaza headul si tail la crearea cozii
{                                // DE ADAUGAT K - CAND CREEZ SAU STERG nodCoada SA SE SCHIMBE POINTERII HEAD AND TAIL SUB nodCoadaUL RESPECTIV
    setbkcolor(COLOR(17,17,17));
    setcolor(COLOR(0,120,255));
    settextstyle(0,0,4);

    int lungime = x/6.8-x/14.3, latime = y/2.75-y/3.05;
    char str[6]="Tail";
    settextstyle(0,0,marimeText(str,lungime,latime));
    outtextxy(x/8.14, y/4, str);                               //   afisare head and tail
    char strr[6]="Head";
    settextstyle(0,0,marimeText(strr,lungime,latime));
    outtextxy(x/8.14, y/2.3, strr);

    line(x/7, y/3.6, x/1.55541, y/2.9);   // linie tail spre pointer null
    setlinestyle(0,0,1);
    line(x/7, y/2.3, x/1.557, y/2.9);  // line head spre pointer null

    setlinestyle(0,0,2);
    line(x/1.55541, y/3.33005, x/1.55541, y/2.57034);
    for (int i=1;i<=14;i++)                                         //   pointer null
        line (x/1.55541,y/(3.33005-0.05*i),x/1.543,y/(3.33-0.05*(i+1)));
    setlinestyle(0,0,1);


}

void transformareText_Coada(char str[], int valoare)            // functie care transforma un numar in sir de caractere
{
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

void desenarenodCoadaNou(int x, int y)     // deseneaza nodul care o sa se adauge la coada
{
    setcolor(COLOR(255,51,0));
    char str[2]="p";
    settextstyle(0,0,4);
    if (x<1300)
        settextstyle(0,0,3);
    // DESENARE nod
        outtextxy(x/22,y/11,str);      // p

        line(x/14.3647, y/8.5185, x/9.39231, y/8.5185);
        line(x/9.39231, y/8.5185, x/9.39231, y/7.51111);       // linie p spre casuta cu nod

        rectangle(x/11.1, y/7.42857, x/8.14, y/5.16031);  // casuta cu nod

        line(x/9.39231, y/5.16031, x/9.39231, y/4.44782);       // desen pointer null
        line(x/10.6174, y/4.44737, x/8.42069, y/4.44737);
        setlinestyle(0,0,1);
        for (int i=0;i<=10;i++)
            line(x/(10.6174-0.2*(i+1)), y/4.44737, x/(10.6174-0.2*i), y/4.34);
        setlinestyle(0,0,0);
    // DESENARE nod
}

// DE AICI SCRIU OPERATIILE PENTRU PUSH
void pEgalNewnodCoada(int x, int y)      // scrie p = new nod in fereastra grafica
{
   // setcolor(COLOR(v[0].r,v[0].g,v[0].b));
    setcolor(COLOR(255,51,0));
    char str[]="p = new nod;";
    settextstyle(0,0,marimeText(str,x/2.83953-x/6.42632,50));
    outtextxy(x/6.42632, y/22, str);
}

void pInfoEgalVal(int x, int y,int val)         // scrie p ->info= val in fereastra grafica
{
   // setcolor(COLOR(v[1].r,v[1].g,v[1].b));
   setcolor(COLOR(255,102,153));
    char str[20]="p -> info =  ;";
    char strr[5]=" ";

    transformareText_Coada(strr,val);
    strcpy(str+12,strr);
    strcat(str,";");
    int lungime = x/9-x/11.1, inaltime = y/5.164-y/7.42857;

    if(val < 10)
    {
        settextstyle(0,0,marimeText(strr,12*(lungime/10),inaltime));
        outtextxy(x/10.178, y/7.193, strr);
    }
        else
        if (val > 9 && val < 100)
        {
            settextstyle(0,0,marimeText(strr,16*(lungime/10),inaltime));
            outtextxy(x/10.7, y/7, strr);
        }
            else
            {
                settextstyle(0,0,marimeText(strr,16*(lungime/10),inaltime));
                outtextxy(x/10.8, y/6.8, strr);
            }

    settextstyle(0,0,marimeText(str,x/2.5438-x/6.42632,50));
    outtextxy(x/6.42637, y/12, str);


}
void TailnextEgalp(int k)  // tail next = p....!!!!
{
    if(k>0)
    {
    setcolor(COLOR(204,51,255));
    char str[20]="tail -> next = p;";
    settextstyle(0,0,marimeText(str,x/2.3-x/6.42632,50));
    outtextxy(x/6.42632, y/8, str);
    }
    if(k == 1 || k == 2)
        line(x/8.14+(x/13.5667*(k-1)), y/3.21905, x/8.14, y/6.18);  // !!!!!!  linie de la casuta cu nod(tail) la next (nod desenat)
        else if (k>2)
        {
            line(x/8.14+(x/13.5667*(k-1)), y/3.21905, x/7, y/ 3.7);
            line(x/7, y/ 3.7, x/8.14, y/6.18);
        }

}
void tailEgalP(int x, int y,int k)
{
    setcolor(COLOR(51,153,255));
    char str[11]="Tail = p;";
    settextstyle(0,0,marimeText(str,x/3-x/6.42632,50));
    if (k==0)
        outtextxy(x/6.42632, y/8, str);
    else
        outtextxy(x/6.42632, y/6, str);

    setcolor(COLOR(17,17,17));

    setlinestyle(0,0,2);
    int c;
    if (k==0||k==1)                 // daca este doar un nod in coada sau nici unul se deseneaza prima legatura in acelasi loc
        c=0;
    else
        c=k-1;

    line(x/7+(x/13.5667*c), y/3.6, x/1.55541, y/2.9);   // stergere linie tail spre pointer null

    if (k==0)
        line(x/8.14+(x/13.5667*k)-(x/27.75)+2, y/2.9, x/1.55541, y/2.9);   // stergere linie nod tail(ultimul din sir) spre pointer null

    setfillstyle(SOLID_FILL,COLOR(17,17,17));
    if (k>0)
        bar(x/1.56, y/3.34, x/1.53, y/2.56);    // stergere pointer null de la sfarsitul sirului de noduri


            setcolor(COLOR(17,17,17));
            char strr[6]="Tail";
            settextstyle(0,0,marimeText(strr, x/6.8-x/14.3, y/2.75-y/3.05));
            if (k==0)
                outtextxy(x/8.14+(x/13.5667*k), y/4, strr);
            else
            {
                outtextxy(x/8.14+(x/13.5667*(k-1)), y/4, strr);
                if (k==1)
                {
                    setlinestyle(0,0,1);
                    setcolor(COLOR(204,51,255));
                    line(x/8.14+(x/13.5667*(k-1)), y/3.21905, x/8.14, y/6.18);
                }
            }

            setcolor(COLOR(0,120,255));
            outtextxy(x/25, y/7, strr);  // scriere tail langa nodul p creat


    setlinestyle(0,0,1);
    setcolor(COLOR(51,153,255));

    rectangle(x/11.1-3, y/7.42857-3, x/8.14+3, y/5.16031+3);        // highlight nod p

}
void operatiiPush_Coada(int x, int y,int val, int k)
{
    int animatie=1000;

    desenarenodCoadaNou(x,y);
    pEgalNewnodCoada(x,y);

    delay(animatie);

    pInfoEgalVal(x,y,val);

    if (k>0)
    {
        delay(animatie);
        setcolor(COLOR(17,17,17));
        line(x/8.14+(x/13.5667*k)-(x/27.75)+2, y/2.9, x/1.55541, y/2.9);   // stergere linie nod tail(ultimul din sir) spre pointer null
    }
    TailnextEgalp(k);

    delay(animatie);

    tailEgalP(x,y,k);

    if (k==0)
    {
        delay(animatie);
        setcolor(COLOR(17,17,17));
        setfillstyle(SOLID_FILL,COLOR(17,17,17));
        bar(x/1.56, y/3.34, x/1.53, y/2.56);    // stergere pointer null de la sfarsitul sirului de noduri
        line(x/7, y/2.3, x/1.557, y/2.9);       // stergere linie head spre pointer null
        setcolor(COLOR(150,200,50));
        char str[11]="Head = p;";
        settextstyle(0,0,marimeText(str,x/3-x/6.42632,50));
        outtextxy(x/6.42632, y/6, str);
        line(x/7, y/2.3, x/8.14, y/6.18);
    }

    delay(animatie);
    setcolor(COLOR(200,100,50));
    apasatiEnter(x,y);

}
void stergereOperatiiPush_Coada(int x, int y,int k)
{
    char tail[6]="Tail";
    settextstyle(0,0,marimeText(tail, x/6.8-x/14.3, y/2.75-y/3.05));
    if (k==0)
    {
        setcolor(COLOR(0,120,255));
        outtextxy(x/8.14+(x/13.5667*k), y/4, tail);
    }
    int lungime = x/6.8-x/14.3, latime = y/2.75-y/3.05;
    setfillstyle(SOLID_FILL,COLOR(17,17,17));
    setcolor(COLOR(17,17,17));

    if (k == 1 || k == 2)
        line(x/8.14+(x/13.5667*(k-1)), y/3.21905, x/8.14, y/6.18);  // !!!!!!  linie de la casuta cu nod(tail) la next (nod desenat)
        else if (k>2)
        {
            line(x/8.14+(x/13.5667*(k-1)), y/3.21905, x/7, y/ 3.7);
            line(x/7, y/ 3.7, x/8.14, y/6.18);
        }

    bar(x/26, y/10.3, x/2, y/4.1);
    bar(x/6.5, 0, x/2, y/4.1);
    line(x/13.6, y/3, x/13.6, y/6.09);  // stergere legatura intre tail si p
    line(x/9.39231, y/3.5, x/1.6, y/3.5);                                                       // stergere legatura intre p si succesor
    line(x/1.54557-(x/13.5666*k)+x/54.2666, y/3.5, x/1.54557-(x/13.5666*k)+x/54.2666, y/3.21905-1);
    line(x/1.6, y/3.5, x/1.55541, y/2.9);           //  stergere legatura intre p si POINTER NULL
    setcolor(COLOR(0,120,255));
    if (k==0)
        line(x/8.14, y/2.9, x/1.55541, y/2.9);   // linie tail spre pointer null
        else
        {
            setcolor(COLOR(17,17,17));
            char str[6]="Tail";
            settextstyle(0,0,marimeText(str,lungime,latime));
            outtextxy(x/8.14+(x/13.5667*(k-1)), y/4, str);                       //   stergere  tail precedent deasupra nodurilor
            setcolor(COLOR(0,120,255));
            outtextxy(x/8.14+(x/13.5667*k), y/4, str);                        //   afisare  tail deasupra nodurilor
        }
    setcolor(COLOR(17,17,17));
    apasatiEnter(x,y);

}

void adaugarenodNou(int x, int y,int val, int k)            // deseneaza un nod nou
{
    if (k==1)
    {
        setcolor(COLOR(17,17,17));
        line(x/7, y/2.3, x/8.14, y/6.18);
    }

        setcolor(COLOR(0,120,255));

        if (k==1)
        line(x/8.14+(x/13.5667*k)-(x/27.75), y/2.9, x/1.55541, y/2.9);          // construire linie de la ultimul nod din sir la null
            else
        line(x/8.14+(x/13.5667*(k-1))-(x/27.75), y/2.9, x/1.55541, y/2.9);

        setlinestyle(0,0,2);
        line(x/1.55541, y/3.33005, x/1.55541, y/2.57034);
        for (int i=1;i<=14;i++)                                               //  desenare pointer null
            line (x/1.55541,y/(3.33005-0.05*i),x/1.543,y/(3.33-0.05*(i+1)));
        setlinestyle(0,0,1);

        bar(x/8.14+(x/13.5667*(k-1)), y/3.21905, x/8.14+(x/13.5667*k)-(x/27.75), y/2.64062);         // stergere linie tail
        //rectangle(x/1.54557-(x/13.5667*k), y/3.21905, x/1.54557-(x/13.5667*(k-1))-(x/27.75), y/2.64062);   // deseneaza casuta valoare nod  // outtextxy(x/8.14, y/4, str);
        rectangle(x/8.14+(x/13.5667*(k-1)), y/3.21905, x/8.14+(x/13.5667*k)-(x/27.75), y/2.64062);

        char str[5]=" ";
        int lungime=x/1.54557-(x/13.5667*(k-1))-(x/27.75)-(x/1.54557-(x/13.5667*k));
        int inaltime=y/2.64062-y/3.21905;

        transformareText_Coada(str,val);

        if(val < 10)
        {
            settextstyle(0,0,marimeText(str,lungime/2,inaltime));
            outtextxy(x/7.5+(x/13.5667*(k-1)), y/3.15, str);
        }
            else
            if (val > 9 && val < 100)
            {
                settextstyle(0,0,marimeText(str,8*(lungime/10),inaltime));
                outtextxy(x/7.8+(x/13.5667*(k-1)), y/3.1, str);
            }
                else
                {
                    settextstyle(0,0,marimeText(str,9*(lungime/10),inaltime));
                    outtextxy(x/7.8+(x/13.5667*(k-1)), y/3.08, str);
                }

}

void stergereLinieHead(int x, int y)
{
    setlinestyle(0,0,2);
    setcolor(COLOR(17,17,17));
    line(x/7, y/2.3, x/1.557, y/2.9);   // stergere linie head spre null

    setlinestyle(0,0,1);
    setcolor(COLOR(0,120,250));
    line(x/7, y/2.3, x/7, y/2.9);  //   line head spre primul nod
}
void creareLinieHeadNull(int x, int y)      // deseneaza legatura intre head si null cand nu exista elemente in coada
{
    setlinestyle(0,0,2);
    setcolor(COLOR(17,17,17));
    line(x/7, y/2.3, x/7, y/2.9);  //  sterge linie head spre primul nod

    setlinestyle(0,0,1);
    setcolor(COLOR(0,120,250));
    line(x/7, y/2.3, x/1.557, y/2.9);   // creeaza linie head spre null
}

void pEgalHead(int x, int y, int k) // afiseaza in fereastra operatiile care se fac la apasarea butonului pop
{
    int lungime = x/6.8-x/14.3, latime = y/2.75-y/3.05;
    settextstyle(0,0,4);
    char str[2]="p";
    setfillstyle(SOLID_FILL,COLOR(17,17,17));
    if (k>1)
    {
      //  STERGERE TEXT HEAD
        setcolor(COLOR(17,17,17));
        char strr[6]="Head";
        settextstyle(0,0,marimeText(strr,lungime,latime));
        outtextxy(x/8.14, y/2.3, strr);

        setcolor(COLOR(255,51,0));
        outtextxy(x/7.3,y/2.3,str);
        line(x/7, y/2.3, x/7, y/2.64062);           // linie de la text `p` la primul nod
        rectangle(x/8.14, y/3.21905, x/8.14+x/13.5667-(x/27.75), y/2.64062);    // highlight primul nod

        char str3[]="p = head;";
        settextstyle(0,0,marimeText(str3,x/2.83953-x/6.42632,y/25));
        outtextxy(x/6.42632, y/22, str3);
    }

}

void headEgalHeadNext(int x, int y,int k)  // afiseaza in fereastra operatiile care se fac la apasarea butonului pop
{
    setcolor(COLOR(17,17,17));
    char str[]="Head";
    int lungime = x/6.8-x/14.3, latime = y/2.75-y/3.05;
    settextstyle(0,0,marimeText(str,lungime,latime));
    setcolor(COLOR(255,102,153));
    if (k>1)
    {
        outtextxy(x/8.14+x/13.5667, y/2.3, str);
        rectangle(x/8.14+x/13.5667, y/3.21905, x/8.14+(x/13.5667*2)-(x/27.75), y/2.64062);    // highlight head -> next
        char str2[]="head = head -> next";
        settextstyle(0,0,marimeText(str2,x/2.3-x/6.42632,50));          //  text head =  head ->next
        outtextxy(x/6.42637, y/12, str2);
    }else
    {
        outtextxy(x/8.14, y/2.3, str);
        rectangle(x/8.14-3, y/3.21905-3, x/8.14+(x/13.5667)-(x/27.75)+3, y/2.64062+3);       // highlight primul nod
        line(x/7, y/2.3, x/7, y/2.64062+3);
    }
}

void stergeP(int x, int y, int k)      // afiseaza in fereastra operatiile care se fac la apasarea butonului pop
{
    if (k>1)
    {
        setcolor(COLOR(204,51,255));
        char str[]="delete p";
        settextstyle(0,0,marimeText(str,x/3-x/6.42632,y/25));
        outtextxy(x/6.42632, y/8, str);
        line(x/6.44, y/7, x/7, y/3.21905);
    } else
    if (k==1)
    {
        setcolor(COLOR(255,102,153));
        char str[]="delete Head";
        outtextxy(x/6.42632, y/8, str);
        line(x/6.44, y/7, x/9.5, y/4);
        line(x/9.5, y/4, x/7, y/3.21905);

    }
    else line(x/6.44, y/7, x/7, y/3.21905);
}

void operatiiPop_Coada(int x, int y, int k)     // afiseaza in fereastra operatiile care se fac la apasarea butonului pop
{
    int animatie = 1000;
    if(k>1)
    {
        pEgalHead(x,y,k);

        delay(animatie);
        headEgalHeadNext(x,y,k);

        delay(animatie);
        stergeP(x,y,k);

        delay(animatie);
        setcolor(COLOR(200,100,50));
        apasatiEnter(x,y);
    }else
    {
        stergeP(x,y,k);
        headEgalHeadNext(x,y,k);

        delay(animatie);
        setcolor(COLOR(200,100,50));
        apasatiEnter(x,y);
    }

}

void stergeOperatiiPop_Coada(int x, int y)
{
    setcolor(COLOR(17,17,17));
}

void stergerenodCoada(int x, int y,int & k, nodCoada *& head)
{
    setcolor(COLOR(0,120,255));
    int lungime = x/6.8-x/14.3, latime = y/2.75-y/3.05;
    nodCoada * p= head;
    delete p;
    k--;
    int i=1;
    char str[]="Tail";
    readimagefile("JPG/backgroundcoada.jpg",0,0,x,y);
    headAndTail(x,y);
    if (k!=0)
    {
        stergereLinieHead(x,y);
        setcolor(COLOR(17,17,17));
        setlinestyle(0,0,2);
        line(x/7, y/3.6, x/1.55541, y/2.9);   // linie tail spre pointer null
        setlinestyle(0,0,1);
        setcolor(COLOR(0,120,255));
        line(x/8.14, y/2.9, x/1.55541, y/2.9);   // linie legatura intre noduri
        settextstyle(0,0,marimeText(str,lungime,latime));
        outtextxy(x/8.14+(x/13.5667*(k-1)), y/4, str);
        setcolor(COLOR(17,17,17));
        if (k>1)
            outtextxy(x/8.14, y/4, str);         //   stergere  tail precedent deasupra nodurilor
    }
    setcolor(COLOR(0,120,255));
    while (p != NULL)
    {
        adaugarenodNou(x,y,p->info,i);
        p = p -> next;
        i++;
    }
}


void clear_Coada(int x, int y,int &k,nodCoada *& head)
{
    nodCoada * p = head;
    while(head != NULL)
    {
        head = head ->next;
        delete p;
        p = head;
    }
    k=0;
    setcolor(COLOR(17,17,17));

}

void salvatiInFisier_Coada(nodCoada* head)
{
    if (head == NULL)
        f<<"Coada este vida";
    else
    {
        while (head!=NULL)
        {
            f << head->info << " ";
            head = head -> next;
        }
    }
    f<<endl;

}

void rezolvaCoada(int x, int y,bool&coada,bool &meniu, bool&secondmain)
{
    int k = 0, val = -1;
    nodCoada* head = NULL;
    nodCoada* tail = NULL;
    readimagefile("JPG/backgroundcoada.jpg",0,0,x,y);
    headAndTail(x,y);
    clearmouseclick(WM_LBUTTONDOWN);
    while (coada == true)
    {
        if (ismouseclick(WM_LBUTTONDOWN))
        {
        cout<<mousex()<<" " <<mousey()<<endl;

                                    // BUTON POP
            if(mousex()>=coordonatePop_Coada.x1 && mousex()<=coordonatePop_Coada.x2 && mousey()>=coordonatePop_Coada.y1 && mousey()<=coordonatePop_Coada.y2 && coada==true)
            {
                if(pop_Coada(head)==0)
                    eroareIsEmpty_Coada(x,y);
                else
                {
                    operatiiPop_Coada(x,y,k);
                    while(kbhit()) getch();
                    getch();

                    if (head==NULL)     // daca am dat pop  la singurul element care exista in coada head este null
                        creareLinieHeadNull(x,y);

                    stergerenodCoada(x,y,k,head);
                    clearmouseclick(WM_LBUTTONDOWN);
                }
                val = -1;

            }else

                                            // BUTON PUSH
                if(mousex()>=coordonatePush_Coada.x1 &&mousex()<=coordonatePush_Coada.x2 && mousey()>=coordonatePush_Coada.y1 && mousey()<=coordonatePush_Coada.y2 && coada == true)
                {
                    if (val == -2)
                        eroareIsFull_Coada(x,y);
                    else
                    {
                        if (val==-1)
                            eroareIntroducetiValoare_Coada(x,y);
                        else
                        {
                            setcolor(COLOR(17,17,17));
                            apasatiPush_Coada(x,y);
                            readimagefile("JPG/introducetiValoareCoada.jpg",x/1.45,y/3.19,x/1.034,y/2.33);
                            operatiiPush_Coada(x,y,val,k);
                            while(kbhit()) getch();
                            getch();
                            stergereOperatiiPush_Coada(x,y,k);
                            k++;
                            if (k==1)
                                stergereLinieHead(x,y);
                            adaugarenodNou(x,y,val,k);
                            push_Coada(head, tail, val);
                            if ((x/8.14+(x/13.5667*(k+1))-(x/27.75))>x/1.55541)
                                val = -2;
                            else
                                val = -1;
                        }
                    }
                    clearmouseclick(WM_LBUTTONDOWN);
                    }else
                                            // BUTON INTRODUCETI VALOARE
                        if(((mousex()>=coordonateIntroducetiValoare_Coada.x1&&mousex()<=coordonateIntroducetiValoare_Coada.x2&&mousey()>=coordonateIntroducetiValoare_Coada.y1&&mousey()<=coordonateIntroducetiValoare_Coada.y2)||
                        (mousex()>=coordonateIntroducetiValoare_Coada.x3&&mousex()<=coordonateIntroducetiValoare_Coada.x4&&mousey()>=coordonateIntroducetiValoare_Coada.y3&&mousey()<=coordonateIntroducetiValoare_Coada.y4))&&coada==true)
                        {
                            if (val == -2)
                            {
                                eroareIsFull_Coada(x,y);
                            }
                            else
                            {
                                setfillstyle(SOLID_FILL,COLOR(17,17,17));
                                bar(x/1.45,y/3.19,x/1.034,y/2.33);
                                introducetiValoare_Coada(x,y,val,k);                       // AICI TREBUIE SA FAC O FUNCTIE CARE TRANSFORMA NUMERE DE TIP INT,SHORT.. IN SIRURI (TIP CHAR)
                            }
                            clearmouseclick(WM_LBUTTONDOWN);
                        }else

                                                // BUTON CLEAR
                        if (mousex() >= coordonateClear_Coada.x1 && mousex() <= coordonateClear_Coada.x2 && mousey() >= coordonateClear_Coada.y1 && mousey() <= coordonateClear_Coada.y2 && coada == true)
                        {
                            if(k != 0)
                            {
                                clear_Coada(x,y,k,head);
                                cleardevice();
                                readimagefile("JPG/backgroundcoada.jpg",0,0,x,y);
                                headAndTail(x,y);
                                val = -1;
                            }else
                                eroareIsEmpty_Coada(x,y);
                            clearmouseclick(WM_LBUTTONDOWN);
                    }else

                                                // BUTON INAPOI LA MENIUL PRINCIPAL
                        if ( mousex() >= coordonateMeniuPrincipal_Coada.x1 && mousex() <= coordonateMeniuPrincipal_Coada.x2 && mousey() >= coordonateMeniuPrincipal_Coada.y1 // &&
                                            && mousey() <= coordonateMeniuPrincipal_Coada.y2 && coada == true)
                        {
                            clear_Coada(x,y,k,head);
                            val = -1;
                            k = 0;
                            cleardevice();
                            readimagefile("JPG/Mainshow.jpg",0,0,x,y);
                            readimagefile("Info/Buton_info.gif",x/1.12359,0,x/1.04564,y/9);
                            coada = false;
                            meniu = true;
                            clearmouseclick(WM_LBUTTONDOWN);
                        }else
                            if (mousex() <= coordonateBack_Coada.x1 && mousey() <= coordonateBack_Coada.y1 && getpixel(mousex(),mousey()) != COLOR(17,17,17))
                            {
                                coada = false;
                                secondmain = true;
                                cleardevice();
                                readimagefile("JPG/Secondmain.jpg",0,0,x,y);
                            }else
                                                                        // BUTON SALVARE IN FISIER
                                if ((mousex() >= coordonateFisier_Coada.x1 && mousex() <= coordonateFisier_Coada.x2 && mousey() >= coordonateFisier_Coada.y1 && mousey() <= coordonateFisier_Coada.y2 ) ||
                                            (mousex() >= coordonateFisier_Coada.x3 && mousex() <= coordonateFisier_Coada.x4 && mousey() >= coordonateFisier_Coada.y3 && mousey() <= coordonateFisier_Coada.y4  ))
                                {
                                    popUpCoadaSalvata(x,y);
                                    salvatiInFisier_Coada(head);
                                }
                  clearmouseclick(WM_LBUTTONDOWN);

                }



    }

}

