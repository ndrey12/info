#ifndef REZOLUTIE_H_INCLUDED
#define REZOLUTIE_H_INCLUDED

//----------------------------------------> Toti am lucrat <------------------------------------

#endif // REZOLUTIE_H_INCLUDED

//int x=getmaxwidth(),y=getmaxheight();

int x =1600;
int y = 800;

void redimensionare(int &x, int &y,int k)
{
    if(k==1)
    {
        x = 1920;
        y = 1080;
    }
    if (k==2)
    {
        x = 1600;
        y = 800;
    }
    if (k==3)
    {
        x = 1280;
        y = 720;
    }

}

