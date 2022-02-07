#ifndef CULORI_H_INCLUDED
#define CULORI_H_INCLUDED



#endif // CULORI_H_INCLUDED

using namespace std;

struct culori{
    int r;
    int g;
    int b;
};
culori v[5];

void colorare(culori v)
{
v[0].r=255;  v[0].g=51;    v[0].b=0;
v[1].r=255;  v[1].g=102;   v[1].b=153;
v[2].r=204;  v[2].g=51;    v[2].b=255;
v[3].r=51;   v[3].g=153;   v[3].b=255;
cout<<"aici"<<endl;
}
             //                                    (COLOR(255,51,0));
    line(x/3.33+1, y/5, x/3.33+1, y/1.057-(0.04*(2*(k+1))*x)-1);
                                                                            //    v[1].r=255;  v[1].g=102;   v[1].b=153;        COLOR(255,102,153)
                                                                             //   v[2].r=204;  v[2].g=51;    v[2].b=255;         COLOR(204,51,255)
                                                                            //    v[3].r=51;   v[3].g=153;   v[3].b=255;         COLOR(51,153,255)



                              if(isEmpty_Coada(head))
                return 0;
                nodCoada* curent = head;
                head = head -> next;
                int rezultat = curent -> info;
                delete curent;
                return rezultat;
