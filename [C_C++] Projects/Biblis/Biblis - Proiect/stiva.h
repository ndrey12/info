#ifndef STIVA_H_INCLUDED
#define STIVA_H_INCLUDED

//----------------------------------------> Structura de date implementata de Dodan Gabriel <------------------------------------

#endif // STIVA_H_INCLUDED

using namespace std;

ofstream g("stiva.txt");

struct nodStiva
{
    int info;
    nodStiva *next;
};

struct butonMeniuPrincipal_Stiva
{
    int x1 = x/1.395;
    int x2 = x/1.05;
    int y1 = y/11.266;
    int y2 = y/3.97;
}coordonateMeniuPrincipal_Stiva;

struct butonIntroducetiValoare_Stiva
{
    int x1 = x/1.433;
    int x2 = x/1.04;
    int y1 = y/3.14;
    int y2 = y/2.73;

    int x3 = x/1.364;
    int x4 = x/1.104;
    int y3 = y/3.15;
    int y4 = y/2.397;
}coordonateIntroducetiValoare_Stiva;

struct butonPush_Stiva
{
    int x1 = x/1.35;
    int x2 = x/1.113;
    int y1 = y/2.048;
    int y2 = y/1.842;
}coordonatePush_Stiva;

struct butonPop_Stiva
{
    int x1 = x/1.333;
    int x2 = x/1.155;
    int y1 = y/1.609;
    int y2 = y/1.466;
}coordonatePop_Stiva;

struct butonClear_Stiva
{
    int x1 = x/1.7955;
    int x2 = x/1.4115;
    int y1 = y/1.6289;
    int y2 = y/1.4857;
}coordonateClear_Stiva;

struct butonBack_Stiva
{
    int x1 = x/11.6;
    int y1 = y/9.94;
}coordonateBack_Stiva;

struct butonFisier_Stiva
{
    int x1 = x/1.471;
    int y1 = 0;
    int x2 = x/1.0617;
    int y2 = y/22.5333;
    int x3 = x/1.3017;
    int y3 = y/22.5333;
    int x4 = x/1.1562;
    int y4 = y/12.29;
}coordonateFisier_Stiva;

void ReinitCoords_st()
{
    coordonateMeniuPrincipal_Stiva.x1 = x/1.395;
    coordonateMeniuPrincipal_Stiva.x2 = x/1.05;
    coordonateMeniuPrincipal_Stiva.y1 = y/11.266;
    coordonateMeniuPrincipal_Stiva.y2 = y/3.97;

    coordonateIntroducetiValoare_Stiva.x1 = x/1.433;
    coordonateIntroducetiValoare_Stiva.x2 = x/1.04;
    coordonateIntroducetiValoare_Stiva.y1 = y/3.14;
    coordonateIntroducetiValoare_Stiva.y2 = y/2.73;

    coordonateIntroducetiValoare_Stiva.x3 = x/1.364;
    coordonateIntroducetiValoare_Stiva.x4 = x/1.104;
    coordonateIntroducetiValoare_Stiva.y3 = y/3.15;
    coordonateIntroducetiValoare_Stiva.y4 = y/2.397;

    coordonatePush_Stiva.x1 = x/1.35;
    coordonatePush_Stiva.x2 = x/1.113;
    coordonatePush_Stiva.y1 = y/2.048;
    coordonatePush_Stiva.y2 = y/1.842;

    coordonatePop_Stiva.x1 = x/1.333;
    coordonatePop_Stiva.x2 = x/1.155;
    coordonatePop_Stiva.y1 = y/1.609;
    coordonatePop_Stiva.y2 = y/1.466;

    coordonateClear_Stiva.x1 = x/1.7955;
    coordonateClear_Stiva.x2 = x/1.4115;
    coordonateClear_Stiva.y1 = y/1.6289;
    coordonateClear_Stiva.y2 = y/1.4857;

    coordonateBack_Stiva.x1 = x/11.6;
    coordonateBack_Stiva.y1 = y/9.94;

    coordonateFisier_Stiva.x1 = x/1.471;
    coordonateFisier_Stiva.y1 = 0;
    coordonateFisier_Stiva.x2 = x/1.0617;
    coordonateFisier_Stiva.y2 = y/22.5333;
    coordonateFisier_Stiva.x3 = x/1.3017;
    coordonateFisier_Stiva.y3 = y/22.5333;
    coordonateFisier_Stiva.x4 = x/1.1562;
    coordonateFisier_Stiva.y4 = y/12.29;

}

nodStiva * top =NULL;

bool isEmpty_Stiva(nodStiva* top)
{
    if (top == NULL)
        return true;
    return false;
}

int peek(nodStiva* top)
{
    if (isEmpty_Stiva(top))
        return 0;
    return top->info;
}

int marimeText_Stiva(char str[],int lungime,int inaltime)
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

void eroareIntroducetiValoare_Stiva(int x, int y)
{
    setcolor(COLOR(200,100,50));
    setbkcolor(COLOR(17,17,17));
    char str[]="Introduceti o valoare";
    settextstyle(0,0,marimeText_Stiva(str,0.4*x,0.2*y));
    outtextxy(0.15*x,0.03*y,str);
    delay(1000);
    setcolor(COLOR(17,17,17));
    outtextxy(0.15*x,0.03*y,str);
}

void eroareIsEmpty_Stiva(int x, int y)
{
    setcolor(COLOR(200,100,50));
    setbkcolor(COLOR(17,17,17));
    char str[]="Eroare - stiva este goala";
    char strr[]="Introduceti o valoare";

    settextstyle(0,0,marimeText_Stiva(str,0.4*x,0.2*y));
    outtextxy(0.15*x,0.03*y,str);
    outtextxy(0.17*x,0.08*y,strr);
    delay(1500);
    setcolor(COLOR(17,17,17));
    outtextxy(0.15*x,0.03*y,str);
    outtextxy(0.17*x,0.08*y,strr);

}

void eroareIsFull_Stiva(int x, int y)
{
    setcolor(COLOR(200,100,50));
    setbkcolor(COLOR(17,17,17));
    char str[]="Eroare - stiva este plina";

    settextstyle(0,0,marimeText_Stiva(str,0.4*x,0.2*y));
    outtextxy(0.15*x,0.03*y,str);

    delay(1000);

    setcolor(COLOR(17,17,17));
    outtextxy(0.15*x,0.03*y,str);
}

void popUpStivaSalvata(int x, int y)
{
    setcolor(COLOR(200,100,50));
    setbkcolor(COLOR(17,17,17));
    char strr[]="Stiva a fost salvata in fisier";

    settextstyle(0,0,marimeText_Stiva(strr,0.4*x,0.2*y));
    outtextxy(0.17*x,0.08*y,strr);
    setcolor(COLOR(17,17,17));
    delay(1500);
    outtextxy(0.17*x,0.08*y,strr);
}

void stergeStiva(nodStiva*& top)
{
    while(top != NULL)
    {
        delete top;
        top = top->next;
    }
}

void sageata_Stiva(int x, int y, int k)
{
    line (0.295*x,y/1.065-(0.04*(2*k)*x),0.3*x,y/1.057-(0.04*(2*k)*x));
    line (0.305*x,y/1.065-(0.04*(2*k)*x),0.3*x,y/1.057-(0.04*(2*k)*x));
}


void linieStiva(int x, int y, int k)
{
    setfillstyle(SOLID_FILL,COLOR(0,120,255));
    setbkcolor(COLOR(17,17,17));
    setcolor(COLOR(0,120,255));
    line (x/3.8, y/5,0.3*x,0.2*y);
    line (x/3.33, y/5, x/3.33, y/1.055);
    char str[]="top";

    sageata_Stiva(x,y,k);

    settextstyle(0,0,marimeText_Stiva(str,x/15.2625,50));
    outtextxy(x/3.8-x/15.074, y/5.7,str);

    bar(0.25*x,y/1.057,0.35*x,y/1.055);
    setlinestyle(0,0,2);
    for (int i=0;i<=19;i++)
        line((0.253+0.005*i)*x,y/1.055,(0.250+0.005*i)*x,y/1.049);
    setlinestyle(0,0,0);

}

void apasatiPush(int x, int y)
{
    char str[]="Apasati butonul push";
    settextstyle(0,0,marimeText_Stiva(str, x/3.47373, y/24.5818));         //  TEXT Apasati butonul push
    outtextxy(x/2.4, y/3, str);
}


void introducetiValoare_Stiva(int &valoare, int x, int y)
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
                        settextstyle(0,0,marimeText_Stiva(str,0.09*x,0.09*y));
                        outtextxy(0.79*x,0.365*y,str);
                    }else
                        if (valoare != 0)
                            break;
            }
        }
    }

    setcolor(COLOR(200,100,50));
    apasatiPush(x,y);

}

void operatiiPop_Stiva(int x,int y, int k)
{
    int animatie = 1000;

    setcolor(COLOR(255,51,0));
    char str3[]="p = top;";
    settextstyle(0,0,marimeText_Stiva(str3, x/4.42391,y/24.5818));
    outtextxy(x/2.4, y/6.7, str3);
    rectangle(0.28*x,y/1.057-(0.04*(2*(k+1))*x),0.32*x, y/1.057-(0.04*(2*k+1)*x)-1);

    delay(animatie);

    setcolor(COLOR(255,102,153));

    char str5[]="top";
    settextstyle(0,0,marimeText_Stiva(str5,x/15.2625,50));
    outtextxy(x/3.8-x/15.074, y/5.7,str5);

    char str1[]="top = top -> next;";
    settextstyle(0,0,marimeText_Stiva(str1, x/3.47373, y/24.5818));
    outtextxy(x/2.4, y/5.7+y/60, str1);





    // STERGERE LEGATURA text(top) si NOD TOP
    setcolor(COLOR(17,17,17));
    line (x/3.8, y/5,0.3*x,0.2*y);
    line(x/3.33-1, y/5, x/3.33-1, y/1.057-(0.04*(2*(k+1))*x)-1);
    line(x/3.33+1, y/5, x/3.33+1, y/1.057-(0.04*(2*(k+1))*x)-1);
    line(x/3.33, y/5, x/3.33, y/1.057-(0.04*(2*(k+1))*x)-1);
    sageata_Stiva(x,y,k+1);
    sageata_Stiva(x,y,k);


    //CONSTRUIRE LEGATURA INTRE text(top) si TOP->SUCCESOR
    setcolor(COLOR(255,102,153));
    line(x/4.4, y/4.3, x/4.4, y/1.057-(0.035*(2*(k+1))*x));
    line(x/4.4, y/1.057-(0.035*(2*(k+1))*x), 0.3*x, y/1.057-(0.04*(2*k)*x));


    delay(animatie);
    setcolor(COLOR(204,51,255));
    char str[]="delete p;";
    settextstyle(0,0,marimeText_Stiva(str, x/4.42391,y/24.5818));
    outtextxy(x/2.4, y/4.9+2*y/60, str);


    // CONSTRUIRE LINIE text ~DELETE P~ - nod P
   // line(x/2.45, y/4.3, x/3 , y/4.3);
   //line(x/3, y/4.3, x/3.33, y/1.057-(0.04*(2*(k+1))*x));
    line(x/2.45, y/3.9, x/3 , y/3.9);
    line(x/3, y/3.9, x/3.33, y/1.057-(0.04*(2*(k+1))*x));
    rectangle(0.28*x,y/1.057-(0.04*(2*(k+1))*x),0.32*x, y/1.057-(0.04*(2*k+1)*x)-1);


    delay(animatie);
    setcolor(COLOR(200,100,50));
    char str2[]="Apasati tasta enter";
    settextstyle(0,0,marimeText_Stiva(str2, x/3.47373, y/24.5818));         //  TEXT Apasati tasta enter
    outtextxy(x/2.4, y/2.3, str2);
}

void stergereOperatiiPop_Stiva(int x,int y,int k)
{
    setcolor(COLOR(17,17,17));

    //STERGERE LEGATURA INTRE text(top) si TOP->SUCCESOR
    line(x/4.4, y/4.3, x/4.4, y/1.057-(0.035*(2*(k+1))*x));
    line(x/4.4, y/1.057-(0.035*(2*(k+1))*x), 0.3*x, y/1.057-(0.04*(2*k)*x));

    //STERGERE LINIE text ~DELETE P~ - NOD P
    line(x/2.45, y/3.9, x/3 , y/3.9);
    line(x/3, y/3.9, x/3.33, y/1.057-(0.04*(2*(k+1))*x));

    bar(x/3.0525, y/25.2666, x/1.4535, y/2.331);

    char str2[]="Apasati tasta enter";
    settextstyle(0,0,marimeText_Stiva(str2, x/3.47373, y/24.5818));         // STERGERE TEXT Apasati tasta enter
    outtextxy(x/2.4, y/2.3, str2);

    setcolor(COLOR(0,120,255));
    char str5[]="top";
    settextstyle(0,0,marimeText_Stiva(str5,x/15.2625,50));
    outtextxy(x/3.8-x/15.074, y/5.7,str5);
}

void transformareText(char str[], int valoare)       // functie care transforma un numar in sir de caractere
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
void stergereOperatiiPush_Stiva(int k, int x, int y)        // PRACTIC STERGE DE PE ECRAN LISTA CU OPERATII CARE SE EFECTUEAZA SI REDESENEAZA LINIA TOP
{
    setcolor(COLOR(17,17,17));
    setfillstyle(SOLID_FILL,COLOR(17,17,17));
    bar(x/3.7567, y/8.45, x/1.4, y/5.2);
    bar(x/3.0525, y/25.2666, x/1.4535, y/2.331);

    char str[2]=" ";
    str[0]='p';
    outtextxy(x/3.65, y/7.5,str);

    line(x/3.4, y/7,x/2.745,y/7);
    line(x/2.745,y/7,x/2.745,y/4.8);
    rectangle(x/2.9, y/4.8,x/2.6,y/3.7);
    line(x/2.745, y/3.7 ,x/2.745,y/3);
    line(x/2.65,y/3,x/2.85,y/3);
    setlinestyle(0,0,1);
    for (int i=0;i<=8;i++)
        line(x/(2.83-0.02*i),y/3,x/(2.84-0.02*i),y/2.95);
    setlinestyle(0,0,0);
    line (x/3.33,y/5,x/2.76, y/5);
    line(x/2.76, y/5, x/2.76, y/4.8);
    line(x/2.745, y/3.7+1, 0.3*x, y/1.057-(0.04*(2*k)*x));
    setcolor(COLOR(0,120,255));
    //  REDESENARE LEGATURA TOP
    line (x/3.8,y/5,0.3*x,y/5);
    line (x/3.33,y/5,0.3*x,y/1.057-(0.04*(2*k*x)));
    //  REDESENARE LEGATURA TOP

    setcolor(COLOR(17,17,17));
    char str5[]="Apasati tasta enter";
    settextstyle(0,0,marimeText_Stiva(str5, x/3.47373, y/24.5818));     // STERGERE TEXT Apasati tasta enter
    outtextxy(x/2.5, y/2, str5);
}

void operatiiPush_Stiva(nodStiva * top, int val,int k, int x, int y)                 // FUNCTIA SCRIE OPERATIILE CARE SE EFECTUEAZA
{
    int animatie = 1000;
    bar(x/2.5, y/4.9,x/1.6,y/3);

    setfillstyle(SOLID_FILL,COLOR(17,17,17));
    bar(x/3.0525, y/25.2666, x/1.4535, y/2.331);

    setcolor(COLOR(255,51,0));
    char str1[]="p = new nod;";
     settextstyle(0,0,marimeText_Stiva(str1, x/5.17373, y/24.5818));
     outtextxy(x/2.4, y/5.7, str1);

    // DESENARE NOD
    char str2[2]=" ";
    str2[0]='p';
        outtextxy(x/3.65, y/8,str2);
        line(x/3.4, y/7,x/2.745,y/7);
        line(x/2.745,y/7,x/2.745,y/4.8);
        rectangle(x/2.9, y/4.8,x/2.6,y/3.7);
        line(x/2.745, y/3.7 ,x/2.745,y/3);
        line(x/2.65,y/3,x/2.85,y/3);
        setlinestyle(0,0,1);
        for (int i=0;i<=8;i++)
            line(x/(2.83-0.02*i),y/3,x/(2.84-0.02*i),y/2.95);
        setlinestyle(0,0,0);
    // DESENARE NOD

    delay(animatie);

    setcolor(COLOR(255,102,153));
    char str[]="p -> info =  ;";
   // str[12] = val+48;
    char strr[5] = " ";
    transformareText(strr,val);
    strcpy(str+12,strr);
    strcat(str,";");
    int lungime = x/2.6-x/2.9, inaltime = y/3.7-y/4.8;

    if(val < 10)
    {
        settextstyle(0,0,marimeText_Stiva(strr,lungime/2,inaltime));
        outtextxy(x/2.8, y/4.7+1,strr);
    }
        else
        if (val > 9 && val < 100)
        {
            settextstyle(0,0,marimeText_Stiva(strr,lungime,inaltime));
            outtextxy(x/2.88, y/4.7+1,strr);
        }
            else
            {
                settextstyle(0,0,marimeText_Stiva(strr,lungime,inaltime));
                outtextxy(x/2.887, y/4.5+1,strr);
            }

    settextstyle(0,0,marimeText_Stiva(str, x/4.42391,y/18.5818));
    outtextxy(x/2.4, y/4.9+y/60, str);

    delay(animatie);

    setcolor(COLOR(204,51,255));
    char str3[]="p -> next = top;";
    outtextxy(x/2.4, y/4.3+2*y/60, str3);

     // STERGERE LINIE NULL NOD
        setcolor(COLOR(17,17,17));
        line(x/2.745, y/3.7+1 ,x/2.745,y/3);
        line(x/2.65,y/3,x/2.85,y/3);
        setlinestyle(0,0,1);
        for (int i=0;i<=8;i++)
            line(x/(2.83-0.02*i),y/3,x/(2.84-0.02*i),y/2.95);
        setlinestyle(0,0,0);
    //  STERGERE LINIE NULL NOD

    setcolor(COLOR(204,51,255));
    //  CONSTRUIRE LINIE SUCCESOR
        line(x/2.745, y/3.7+1, 0.3*x, y/1.057-(0.04*(2*k)*x));
    //  CONSTRUIRE LINIE SUCCESOR

    delay(animatie);


    setcolor(COLOR(51,153,255));
    char str4[]="top = p;";
    outtextxy(x/2.4, y/3.8+3*y/60, str4);
    // LINIE TOP SPRE P
    line (x/3.8,y/5,x/2.76, y/5);
    line(x/2.76, y/5, x/2.76, y/4.8);
    setcolor(COLOR(17,17,17));
    // LINIE TOP -- P;
    line(x/3.33-1, y/5+1, x/3.33-1, y/1.057-(0.04*(2*k)*x));
    line(x/3.33+1, y/5+1, x/3.33+1, y/1.057-(0.04*(2*k)*x));
    line(x/3.33, y/5+1, x/3.33, y/1.057-(0.04*(2*k)*x));
    // LINIE TOP SPRE P
    setcolor(COLOR(204,51,255));
    line(x/2.745, y/3.7+1, 0.3*x, y/1.057-(0.04*(2*k)*x));  // pt bug(aparea linie cu un pixel mai la stanga)
    sageata_Stiva(x,y,k);

    delay(animatie);
    setcolor(COLOR(200,100,50));
    char str5[]="Apasati tasta enter";
    settextstyle(0,0,marimeText_Stiva(str5, x/3.47373, y/24.5818));
    outtextxy(x/2.5, y/2, str5);

}

void push_Stiva(nodStiva*& top, int & val,int k,int x,int y)
{
    char str[5]=" ";
    readimagefile("JPG/introducetiValoareCoada.jpg",x/1.45,y/3.19,x/1.034,y/2.33);

    setbkcolor(COLOR(17,17,17));
    // STERGERE LEGATURA PRECEDENTA INTRE NODURI
    setcolor(COLOR(17,17,17));
    line(x/3.33,y/1.057-(0.04*(2*k)*x),x/3.33,y/1.057-(0.04*(2*(k-1)*x)));
    // STERGERE LEGATURA PRECEDENTA INTRE NODURI

    setcolor(COLOR(0,120,255));
    // CREARE LEGATURA INTRE NODURI
    line(x/3.33,y/1.057-(0.04*(2*k)*x),x/3.33,y/1.057-(0.04*(2*(k-1)*x)));
    // CREARE LEGATURA INTRE NODURI

    int lungime=0.9*0.04*x;
    //settextstyle(0,0,marimeText_Stiva(str,lungime,lungime));
    setlinestyle(0,0,0);
    setfillstyle(SOLID_FILL,COLOR(17,17,17));
    bar(0.28*x,y/1.057-(0.04*(2*k)*x),0.32*x,y/1.057-(0.04*(2*k-1)*x)-1);                    // STERGERE LINIE TOP SPRE NOD IN LOCUL UNDE VA FI DESENAT
    rectangle(0.28*x,y/1.057-(0.04*(2*k)*x),0.32*x,y/1.057-(0.04*(2*k-1)*x)-1);             // CASUTELE SUNT PATRATE
    sageata_Stiva(x,y,k-1);

    transformareText(str,val);

    if (val<10)
    {
        settextstyle(0,0,marimeText_Stiva(str,lungime/2,lungime));
        outtextxy(0.294*x,y/1.04-(0.04*(2*k)*x),str);
    }else if (val > 9 && val < 100)
            {
               settextstyle(0,0,marimeText_Stiva(str,lungime,lungime));
                outtextxy(0.2843*x,y/1.042-(0.04*(2*k)*x),str);
            }else
                {
                    settextstyle(0,0,marimeText_Stiva(str,lungime,lungime));
                    outtextxy(0.284*x,y/1.038-(0.04*(2*k)*x),str);
                }

    nodStiva* curent = new nodStiva();
    curent->info = val;
    curent->next = top;
    top = curent;
    if (y/1.057-(0.04*(2*(k+1))*x)<y/5)
        val= -2;
    else
        val=-1;

}

int pop_Stiva(nodStiva*& top,int &k, int x, int y)
{
    setcolor(COLOR(17,17,17));
    if(k>0)
    {
        if (isEmpty_Stiva(top))
            return 0;
        nodStiva* curent = top;
        int peek = curent->info;
        setfillstyle(SOLID_FILL,COLOR(17,17,17));
         bar(0.28*x,y/1.057-(0.04*(2*k)*x),0.32*x+1,y/1.057-(0.04*(2*k-1)*x));
        top = top->next;
        k--;
        delete curent;
        return peek;
    }
    setcolor(COLOR(17,17,17));
    setfillstyle(SOLID_FILL,COLOR(17,17,17));
    bar(x/3.7567, y/8.45, x/1.4, y/5.2);
    bar(x/3.0525, y/25.2666, x/1.4535, y/2.331);
    return 0;
}

void clear_Stiva(int x, int y,int &k,nodStiva *& top)
{
    nodStiva * p = top;
    while(top != NULL)
    {
        top = top ->next;
        delete p;
        p = top;
    }
    k=0;
    setcolor(COLOR(17,17,17));

}
void salvatiInFisier_Stiva(nodStiva* top)
{
    if (top == NULL)
        g<<"Stiva este vida";
    else
    {
        int v[10];
        nodStiva *p = top;
        for (int i=0;i<10;i++)
            v[i]=0;
        int i=0;
        while (p!=NULL)
        {
            v[i] = p ->info;
            p = p->next;
            i++;
        }
        i--;
        while (i>=0)
        {
            g<<v[i]<<" ";
            i--;
        }
    }
    g<<endl;

}
void rezolvaStiva(int x, int y, bool &stiva, bool &meniu, bool &secondmain)
{
    readimagefile("JPG/backgroundstiva.jpg",0,0,x,y);
    setfillstyle(SOLID_FILL,COLOR(17,17,17));
    bar(x/4.66,y/1.205,x/2.725,y);
     int k=0,val=-1;
    linieStiva(x,y,k);

    nodStiva* top = new nodStiva();
    top = NULL;
    settextstyle(0,0,4);
    clearmouseclick(WM_LBUTTONDOWN);

    while (stiva == true)
    {
        if (ismouseclick(WM_LBUTTONDOWN))
        {

                                        // BUTON POP
                if(mousex()>=coordonatePop_Stiva.x1 && mousex()<=coordonatePop_Stiva.x2 && mousey()>=coordonatePop_Stiva.y1 && mousey()<=coordonatePop_Stiva.y2 && stiva == true)
                {
                    setcolor(COLOR(17,17,17));
                    if (k==0)
                    {
                        eroareIsEmpty_Stiva(x, y);
                    }else
                        {
                           // sageata_Stiva(x,y,k+1);
                            operatiiPop_Stiva(x,y,k-1);
                            while(kbhit()) getch();
                            getch();
                        }
                    pop_Stiva(top,k,x,y);
                    stergereOperatiiPop_Stiva(x,y,k);

                    setcolor(COLOR(0,120,255));
                    sageata_Stiva(x,y,k);
                    line (x/3.8, y/5,0.3*x,0.2*y);
                    line(x/3.33, y/5+1, x/3.33, y/1.057-(0.04*(2*k)*x)); // desenare linie top - nodStiva curent
                    val = -1;
                    clearmouseclick(WM_LBUTTONDOWN);
                } else

                                                // BUTON INTRODUCETI VALOARE
                if(((mousex()>=coordonateIntroducetiValoare_Stiva.x1&&mousex()<=coordonateIntroducetiValoare_Stiva.x2&&mousey()>=coordonateIntroducetiValoare_Stiva.y1&&mousey()<=coordonateIntroducetiValoare_Stiva.y2)||
                       (mousex()>=coordonateIntroducetiValoare_Stiva.x3&&mousex()<=coordonateIntroducetiValoare_Stiva.x4&&mousey()>=coordonateIntroducetiValoare_Stiva.y1&&mousey()<=coordonateIntroducetiValoare_Stiva.y4)) && stiva == true)
                {
                    if (val == -2)
                    {
                        eroareIsFull_Stiva(x,y);
                    }else
                    {
                        setfillstyle(SOLID_FILL,COLOR(17,17,17));
                        bar(x/1.45,y/3.19,x/1.034,y/2.33);          // sterge butonul introduceti valoare
                        introducetiValoare_Stiva(val,x, y);
                        clearmouseclick(WM_LBUTTONDOWN);
                    }
                } else

                                            // BUTON PUSH
                if(mousex()>=coordonatePush_Stiva.x1 &&mousex()<=coordonatePush_Stiva.x2 && mousey()>=coordonatePush_Stiva.y1 && mousey()<=coordonatePush_Stiva.y2 && stiva == true)
                {
                    if (val == -1)
                    {
                        eroareIntroducetiValoare_Stiva(x,y);
                    } else
                    {
                        if (val == -2)
                        {
                              eroareIsFull_Stiva(x,y);
                        }
                            else
                            {
                                setcolor(COLOR(17,17,17));
                                apasatiPush(x,y);                 // sterge text apasati push
                                operatiiPush_Stiva(top,val,k,x,y);
                                while(kbhit()) getch();
                                getch();
                                stergereOperatiiPush_Stiva(k,x,y);
                                k++;
                                sageata_Stiva(x,y,k);
                                push_Stiva(top, val, k, x, y);
                                clearmouseclick(WM_LBUTTONDOWN);
                            }
                    }
                    clearmouseclick(WM_LBUTTONDOWN);
                }else
                                // BUTON CLEAR
                if (mousex() >= coordonateClear_Stiva.x1 && mousex() <= coordonateClear_Stiva.x2 && mousey() >= coordonateClear_Stiva.y1 && mousey() <= coordonateClear_Stiva.y2 && stiva == true)
                {
                    if(k != 0)
                    {
                    clear_Stiva(x,y,k,top);
                    cleardevice();
                    readimagefile("JPG/backgroundstiva.jpg",0,0,x,y);
                    bar(x/4.66,y/1.205,x/2.725,y);
                    linieStiva(x,y,k);
                    val = -1;
                    }else
                        eroareIsEmpty_Stiva(x,y);
                }else
                                                            // BUTON INAPOI LA MENIUL PRINCIPAL
                    if ( mousex() >= coordonateMeniuPrincipal_Stiva.x1 && mousex() <= coordonateMeniuPrincipal_Stiva.x2 && mousey() >= coordonateMeniuPrincipal_Stiva.y1 // &&
                                    && mousey() <= coordonateMeniuPrincipal_Stiva.y2 && stiva == true)
                    {
                        stergeStiva(top);
                        val = -1;
                        k = 0;
                        cleardevice();
                        readimagefile("JPG/Mainshow.jpg",0,0,x,y);
                        readimagefile("Info/Buton_info.gif",x/1.12359,0,x/1.04564,y/9);
                        stiva = false;
                        meniu = true;
                    }else
                                                        // BUTON BACK / SPRE SECONDMAIN
                        if ( mousex() <= coordonateBack_Stiva.x1 && mousey() <= coordonateBack_Stiva.y1 && getpixel(mousex(),mousey()) != COLOR(17,17,17))
                        {
                            stiva = false;
                            secondmain = true;
                            cleardevice();
                            readimagefile("JPG/Secondmain.jpg",0,0,x,y);
                        }else
                                                                    // BUTON SALVARE IN FISIER
                            if ((mousex() >= coordonateFisier_Stiva.x1 && mousex() <= coordonateFisier_Stiva.x2 && mousey() >= coordonateFisier_Stiva.y1 && mousey() <= coordonateFisier_Stiva.y2 ) ||
                                        (mousex() >= coordonateFisier_Stiva.x3 && mousex() <= coordonateFisier_Stiva.x4 && mousey() >= coordonateFisier_Stiva.y3 && mousey() <= coordonateFisier_Stiva.y4  ))
                            {
                                popUpStivaSalvata(x,y);
                                salvatiInFisier_Stiva(top);
                            }

        clearmouseclick(WM_LBUTTONDOWN);

        }

    }
}


