
#include <iostream>
#include <cstring>
#include <winbgim.h>
#include <fstream>
//----------------------------------------> Toti <------------------------------------
#include "Rezolutie.h"
#include "coada.h"
#include "stiva.h"
#include "listasimplui.h"
#include "listadublui.h"

using namespace std;

struct butonOptiuni{
    int x1 = x/2.22;
    int x2 = x/4.77;
    int y1 = y/1.35;
    int y2 = y/1.56;
}coordonateButonOptiuni;

struct butonListeDublui{

    int x1 = x/16;
    int x2 = x/4.1025;
    int y1 = y/1.4414;
    int y2 = y/1.2213;

}coordonateButonListeDublui;

struct butonIncepe
{
    int x1 = x/4.507;
    int x2 = x/2.23;
    int y1 = y/2.66;
    int y2 = y/1.93;
}coordonateButonIncepe;

struct butonBack
{
    int x1 = 0;
    int x2 = x/13.3333;
    int y1 = 0;
    int y2 = y/13.3333;
}coordonateButonBack_Main;

struct backOptiuni
{
    int x1 = 0;
    int y1 = 0;
    int x2 = x/11.111;
    int y2 = y/9.638;
}coordonatebackOptiuni;

struct rezolutie1
{
    int x1 = x/2.4729;
    int y1 = y/2.2598;
    int x2 = x/1.6614;
    int y2 = y/1.9417;
}coordonateRezolutie1;

struct rezolutie2
{
    int x1 = x/2.4060;
    int y1 = y/1.8140;
    int x2 = x/1.6965;
    int y2 = y/1.6;
}coordonateRezolutie2;

struct rezolutie3
{
    int x1 = x/2.4096;
    int y1 = y/1.5325;
    int x2 = x/1.6985;
    int y2 = y/1.3628;
}coordonateRezolutie3;

void ReinitCoords_main()
{
    coordonateButonOptiuni.x1 = x/2.22;
    coordonateButonOptiuni.x2 = x/4.77;
    coordonateButonOptiuni.y1 = y/1.35;
    coordonateButonOptiuni.y2 = y/1.56;

    coordonateButonListeDublui.x1 = x/16;
    coordonateButonListeDublui.x2 = x/4.1025;
    coordonateButonListeDublui.y1 = y/1.4414;
    coordonateButonListeDublui.y2 = y/1.2213;

    coordonateButonIncepe.x1 = x/4.507;
    coordonateButonIncepe.x2 = x/2.23;
    coordonateButonIncepe.x1 = y/2.66;
    coordonateButonIncepe.y2 = y/1.93;


    coordonateButonBack_Main.x1 = 0;
    coordonateButonBack_Main.x2 = x/13.3333;
    coordonateButonBack_Main.y1 = 0;
    coordonateButonBack_Main.y2 = y/13.3333;

    coordonatebackOptiuni.x1 = 0;
    coordonatebackOptiuni.y1 = 0;
    coordonatebackOptiuni.x2 = x/11.111;
    coordonatebackOptiuni.y2 = y/9.638;

    coordonateRezolutie1.x1 = x/2.4729;
    coordonateRezolutie1.y1 = y/2.2598;
    coordonateRezolutie1.x2 = x/1.6614;
    coordonateRezolutie1.y2 = y/1.9417;

    coordonateRezolutie2.x1 = x/2.4060;
    coordonateRezolutie2.y1 = y/1.8140;
    coordonateRezolutie2.x2 = x/1.6965;
    coordonateRezolutie2.y2 = y/1.6;

    coordonateRezolutie3.x1 = x/2.4096;
    coordonateRezolutie3.y1 = y/1.5325;
    coordonateRezolutie3.x2 = x/1.6985;
    coordonateRezolutie3.y2 = y/1.3628;

}

int main()
{
    bool ok = true,meniu = true , coada = false, secondmain = false, stiva = false;        // 32 97 249
    bool mainliste = false, listesimple = false, listeduble = false, optiuni = false;
    int rezolutie = 0;
    initwindow(x,y);
    readimagefile("JPG/Mainshow.jpg",0,0,x,y);
    readimagefile("Info/Buton_info.gif",x/1.12359,0,x/1.04564,y/9);
     int p = 0;
     bool muzica = false;
    while (ok)
    {

        if(mousex()>= x/1.12359 && mousex()<= x/1.04564 && mousey()>= 0 && mousey() <= y/9 && meniu == true)
        {
            if(p == 0){
                p = 1;
            readimagefile("Info/Echipa.gif",x/1.33,y/6.72268,x/1.064259,y/1.92771);
            }

        }

          else if(p == 1){
            readimagefile("JPG/Mainshow.jpg",0,0,x,y);
            readimagefile("Info/Buton_info.gif",x/1.12359,0,x/1.04564,y/9);
            p = 0;
          }





        if (ismouseclick(WM_LBUTTONDOWN))
        {

        if (meniu == true)                      // BUTON OPTIUNI
                {
                    if (mousex() >= coordonateButonIncepe.x1 && mousex() <= coordonateButonIncepe.x2 && mousey() >= coordonateButonIncepe.y1 && mousey() <= coordonateButonIncepe.y2 && coada == false && stiva == false && secondmain == false)
                    {
                        cleardevice() ;
                        readimagefile("JPG/Secondmain.jpg",0,0,x,y);
                        secondmain = true;
                        meniu = false;
                        clearmouseclick(WM_LBUTTONDOWN);
                    }
                    if (mousex() <= coordonateButonOptiuni.x1 && mousex() >= coordonateButonOptiuni.x2 && mousey() <= coordonateButonOptiuni.y1 && mousey() >= coordonateButonOptiuni.y2 && coada == false && stiva == false && meniu == true )
                    {
                        cleardevice();
                        meniu = false;
                        optiuni = true;
                        readimagefile("JPG/Optiuni.jpg",0,0,x,y);
                        if(muzica == true)
                        readimagefile("JPG/Music_on.gif",x/2.388059,y/1.24031,x/1.722282,y/1.041666);
                        else
                        readimagefile("JPG/Music_off.gif",x/2.388059,y/1.24031,x/1.722282,y/1.041666);
                        clearmouseclick(WM_LBUTTONDOWN);
                    }
                }
                else
                {
                    if (optiuni == true)
                    {

                    if (mousex() >= coordonateRezolutie1.x1 && mousex() <= coordonateRezolutie1.x2 && mousey() >= coordonateRezolutie1.y1 && mousey() <= coordonateRezolutie1.y2 && optiuni == true)
                    {
                        rezolutie = 1;
                        redimensionare(x,y,rezolutie);
                        closegraph();
                        cout<<x<<" "<<y;
                        ReinitCoords_main();
                        ReinitCoords_li();
                        ReinitCoords_queue();
                        ReinitCoords_st();
                        initwindow(x,y);
                        readimagefile("JPG/Optiuni.jpg",0,0,x,y);
                        if(muzica == true)
                        readimagefile("JPG/Music_on.gif",x/2.388059,y/1.24031,x/1.722282,y/1.041666);
                        else
                        readimagefile("JPG/Music_off.gif",x/2.388059,y/1.24031,x/1.722282,y/1.041666);
                        clearmouseclick(WM_LBUTTONDOWN);
                    }
                    if (mousex() >= coordonateRezolutie3.x1 && mousex() <= coordonateRezolutie3.x2 && mousey() >= coordonateRezolutie3.y1 && mousey() <= coordonateRezolutie3.y2 && optiuni == true)
                    {
                        rezolutie = 3;
                        redimensionare(x,y,rezolutie);
                        closegraph();
                        cout<<x<<" "<<y;
                        ReinitCoords_main();
                        ReinitCoords_li();
                        ReinitCoords_queue();
                        ReinitCoords_st();
                        initwindow(x,y);
                        readimagefile("JPG/Optiuni.jpg",0,0,x,y);
                        if(muzica == true)
                        readimagefile("JPG/Music_on.gif",x/2.388059,y/1.24031,x/1.722282,y/1.041666);
                        else
                        readimagefile("JPG/Music_off.gif",x/2.388059,y/1.24031,x/1.722282,y/1.041666);
                        clearmouseclick(WM_LBUTTONDOWN);
                    }
                    if (mousex() >= coordonateRezolutie2.x1 && mousex() <= coordonateRezolutie2.x2 && mousey() >= coordonateRezolutie2.y1 && mousey() <= coordonateRezolutie2.y2 && optiuni == true)
                    {
                        rezolutie = 2;
                        redimensionare(x,y,rezolutie);
                        closegraph();
                        cout<<x<<" "<<y;
                        ReinitCoords_main();
                        ReinitCoords_li();
                        ReinitCoords_queue();
                        ReinitCoords_st();
                        initwindow(x,y);
                        readimagefile("JPG/Optiuni.jpg",0,0,x,y);
                        if(muzica == true)
                        readimagefile("JPG/Music_on.gif",x/2.388059,y/1.24031,x/1.722282,y/1.041666);
                        else
                        readimagefile("JPG/Music_off.gif",x/2.388059,y/1.24031,x/1.722282,y/1.041666);
                        clearmouseclick(WM_LBUTTONDOWN);
                    }
                     if(mousex() >= x/1.9925 && mousex() <= x/1.74102 && mousey() >= y/1.22137 && mousey() <= y/1.0554 && optiuni == true){
                            readimagefile("JPG/Music_on.gif",x/2.388059,y/1.24031,x/1.722282,y/1.041666);
                            muzica = true;
                            mciSendString("play Muzica.mp3 repeat", NULL, 0, NULL);


                    }
                    if(mousex() >= x/2.3564 && mousex() <= x/2 && mousey() >= y/1.221374 && mousey() <= y/1.05680 && optiuni == true){
                        readimagefile("JPG/Music_off.gif",x/2.388059,y/1.24031,x/1.722282,y/1.041666);
                        muzica = false;
                         mciSendString("Close Muzica.mp3", NULL, 0, NULL);
                    }

                    }
                    if (mousex() >= coordonatebackOptiuni.x1 && mousex() <= coordonatebackOptiuni.x2 && mousey() >= coordonatebackOptiuni.y1 && mousey() <= coordonatebackOptiuni.y2 && secondmain == true)
                    {
                        cleardevice();
                        meniu = true;
                        secondmain = false;
                        readimagefile("JPG/Mainshow.jpg",0,0,x,y);
                         readimagefile("Info/Buton_info.gif",x/1.12359,0,x/1.04564,y/9);
                        clearmouseclick(WM_LBUTTONDOWN);
                    }

                    if (mousex() >= coordonatebackOptiuni.x1 && mousex() <= coordonatebackOptiuni.x2 && mousey() >= coordonatebackOptiuni.y1 && mousey() <= coordonatebackOptiuni.y2 && optiuni == true)
                    {
                        cleardevice();
                        meniu = true;
                        optiuni = false;
                        readimagefile("JPG/Mainshow.jpg",0,0,x,y);
                         readimagefile("Info/Buton_info.gif",x/1.12359,0,x/1.04564,y/9);
                        clearmouseclick(WM_LBUTTONDOWN);
                    }

                                      // BUTON CREEAZA-/STIVE
                    if (mousex() >= x/2.5 && mousex() <= x/1.78 && mousey() >= y/2.28 && mousey() <= y/1.78 && stiva == false && secondmain == true)
                    {
                        stiva = true;
                        secondmain = false;
                        rezolvaStiva(x,y,stiva,meniu,secondmain);
                    }
                                        //BUTON CREEAZA COADA
                            if (mousex() >= x/2.44 && mousex() <= x/1.81 && mousey() >= y/1.55 && mousey() <= y/1.32 && coada == false && stiva == false && secondmain == true)
                            {
                                coada = true;
                                secondmain = false;
                                cleardevice();
                                rezolvaCoada(x,y,coada,meniu,secondmain);
                            }
                            else
                            {
                                                // BUTON SPRE MENIUL LISTE
                                if(meniu == false && secondmain == true && mainliste == false)
                                    if((mousex()>=x/2.51 && mousex()<=x/1.77) && (mousey()>=y/4.14 && mousey()<=y/2.78) && meniu == false && secondmain == true)
                                    {
                                        cleardevice();
                                        readimagefile("JPG/main_Liste.jpg",0,0,x,y);
                                        secondmain = false;
                                        mainliste = true;
                                        clearmouseclick(WM_LBUTTONDOWN);

                                    }
                                                // BUTON SPRE LISTE SIMPLE
                                if(meniu == false && secondmain == false && mainliste == true)
                                    {
                                        if(mousex()>=x/1.53 && mousex()<=x/1.08 && mousey()>=y/9.4 && mousey()<=y/3.5)
                                        {
                                            mainliste = false;
                                            listesimple = true;
                                            clearmouseclick(WM_LBUTTONDOWN);
                                            rezolvaListeSimple(listesimple,mainliste);
                                        }
                                    }

                                if (meniu == false &&secondmain == false && mainliste == true)
                                {
                                    if (mousex() >= coordonateButonListeDublui.x1 && mousex() <= coordonateButonListeDublui.x2 && mousey() >= coordonateButonListeDublui.y1 && mousey() <= coordonateButonListeDublui.y2 )
                                    {
                                        mainliste = false;
                                        listeduble = true;
                                        clearmouseclick(WM_LBUTTONDOWN);
                                        DoubleListInit(mainliste,listeduble);
                                    }
                                    if (mousex() >= coordonateButonBack_Main.x1 && mousex() <= coordonateButonBack_Main.x2 && mousey() >= coordonateButonBack_Main.y1 && mousey() <= coordonateButonBack_Main.y2 )
                                    {
                                        mainliste = false;
                                        secondmain = true;
                                        clearmouseclick(WM_LBUTTONDOWN);
                                        cleardevice();
                                        readimagefile("JPG/Secondmain.jpg",0,0,x,y);
                                    }
                                }
                            }
                }

                clearmouseclick(WM_LBUTTONDOWN);
       }
        if (ismouseclick(WM_RBUTTONDOWN))
            ok = false;
    }
}
