#ifndef LISTADUBLUI_H_INCLUDED
#define LISTADUBLUI_H_INCLUDED

//----------------------------------------> Structura de date implementata de Andrei Doroftei <------------------------------------

#endif // LISTADUBLUI_H_INCLUDED

#include <stack>

using namespace std;

int PixelsX  = x;
int PixelsY  = y;
int fontSize = 2;
int x_1 , x_2, x_3, x_4, x_6, x_10;
int y_1 , y_3, y_5, y_10;
int side = 0; ///0 front, 1 back
int speed = 2000;
struct Nod
{
    int x1, y1, x2, y2;
    int info;
    Nod *st, *dr;
} *ft, *lt;
void ClearLog(int pos) /// 0 for all pos
{
    setfillstyle(SOLID_FILL, BLACK);
    if(pos == 0)
    {
        bar(PixelsX * 70 / 100, PixelsY * (70 + pos * 3 - 3)/ 100, PixelsX, PixelsY);
        return;
    }
    bar(PixelsX * 70 / 100, PixelsY * (70 + pos * 3 - 3)/ 100, PixelsX, PixelsY * (70 + pos * 3 - 3)/ 100 + textheight("123"));
}
void PrintLogs(char str[], int pos)
{
    outtextxy(PixelsX * 70 / 100, PixelsY * (70 + pos * 3 - 3)/ 100, str);
}
int GetFontSize(char str[],int lungime,int inaltime)
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
void PrintError(char str[], int dltime)
{
    setcolor(RED);
    outtextxy(PixelsX * 15 / 100, PixelsY * 96 / 100 , str);
    delay(dltime);

    setfillstyle(SOLID_FILL, BLACK);
    bar(PixelsX * 15 / 100, PixelsY * 96 / 100, PixelsX * 67 / 100, PixelsY );
    setcolor(WHITE);

}
void Null_Right(int x1, int y1, int x2, int y2)
{
    line(x2, y2 - y_1, x2 + x_3, y2 - y_1);
    line(x2 + x_3, y2 - y_1, x2 + x_3, y2 + y_1);
    line(x2 + x_3, y2 + y_1, x2 + x_2, y2 + y_1);
    line(x2 + x_3, y2 + y_1, x2 + x_4, y2 + y_1);
}
void Null_Left(int x1, int y1, int x2, int y2)
{
    line(x1, y1 + y_1, x1 - x_3, y1 + y_1);
    line(x1 - x_3, y1 + y_1, x1 - x_3, y2);
    line(x1 - x_3, y2, x1 - x_2, y2);
    line(x1 - x_3, y2, x1 - x_4, y2);
}
int CountNodes()
{
    int nrN = 0;
    Nod* var = new Nod;
    var = ft;
    while(var != NULL)
    {
        nrN++;
        var = var -> dr;
    }
    return nrN;
}
void VisualKEdit(int value, Nod * cNode)
{
    setfillstyle(SOLID_FILL, BLACK);
    bar(cNode -> x1 + x_2 + 2, cNode -> y1 + 1, cNode -> x2 - x_2 - 2, cNode -> y2 - 1);
    settextstyle(GOTHIC_FONT, HORIZ_DIR, fontSize);
    char s[6];
    stack <char> stck;
    while(value != 0)
    {
        stck.push(value % 10 + '0');
        value /= 10;
    }
    int i = 0;
    while(!stck.empty())
    {
        s[i++] = stck.top();
        stck.pop();
    }
    s[i] = 0;
    setcolor(RED);
    outtextxy(cNode -> x1 + x_2 + 2, cNode -> y1 + 1, s);
    setcolor(WHITE);
    PrintLogs("kNode -> info = value", 1);
    delay(speed);
    ClearLog(0);
}
void VisualAddNode_Back(int value, int pos, Nod* cNode)
{
    int x1, x2, y1, y2;
    x1 = PixelsX * 27 / 100;
    y1 = y_10 + (CountNodes()/4 + 1) * (y_3 + y_5);
    x2 = x1 + x_10;
    y2 = y1 + y_3;
    setcolor(RED);
    line(x1, y1, x2, y1);
    line(x1, y1, x1, y2);
    line(x2, y1, x2, y2);
    line(x1, y2, x2, y2);
    line(x1 + x_2, y1, x1 + x_2, y2);
    line(x2 - x_2, y1, x2 - x_2, y2);
    setcolor(WHITE);
    PrintLogs("Nod* var = new Nod;", 1);
    setcolor(RED);
    settextstyle(GOTHIC_FONT, HORIZ_DIR, fontSize);
    char s[6];
    stack <char> stck;
    while(value != 0)
    {
        stck.push(value % 10 + '0');
        value /= 10;
    }
    int i = 0;
    while(!stck.empty())
    {
        s[i++] = stck.top();
        stck.pop();
    }
    s[i] = 0;
    delay(speed);
    outtextxy(x1 + x_2 + 2, y1 + 1, s);
    setcolor(WHITE);
    PrintLogs("var -> info = value;", 2);
    setcolor(RED);
    delay(speed);
    if(pos == 1)
    {
        Null_Right(x1, y1, x2, y2);
        setcolor(WHITE);
        PrintLogs("var -> right = NULL;", 3);
        setcolor(RED);
        delay(speed);
        line(x1, y1 + y_1, cNode -> x2, cNode -> y1 + y_1);
        setcolor(WHITE);
        PrintLogs("var -> left = kNode;", 4);
        setcolor(RED);
        delay(speed);
        line(x1, y2 - y_1, cNode -> x2, cNode -> y2 - y_1);
        setcolor(WHITE);
        PrintLogs("kNode -> right = var;", 5);
        setcolor(RED);
        delay(speed);
        setcolor(WHITE);
        PrintLogs("last = var;", 6);
        delay(speed);
    }
    else if(pos == CountNodes() + 1)
    {
        Null_Left(x1, y1, x2, y2);
        setcolor(WHITE);
        PrintLogs("var -> left = NULL;", 3);
        setcolor(RED);
        delay(speed);

        line(x2, y1 + y_1, cNode -> x1, cNode -> y1 + y_1);
        setcolor(WHITE);
        PrintLogs("kNode -> left = var;", 4);
        setcolor(RED);
        delay(speed);

        line(x2, y2 - y_1, cNode -> x1, cNode -> y2 - y_1);
        setcolor(WHITE);
        PrintLogs("var -> right = kNode;", 5);
        setcolor(RED);
        delay(speed);
        setcolor(WHITE);
        PrintLogs("first = var;", 6);
        delay(speed);
    }
    else
    {
        delay(speed);

        setcolor(WHITE);
        PrintLogs("kNode -> right -> left = var;", 3);
        setcolor(RED);
        line(x2, y1 + y_1, cNode -> dr-> x1, cNode -> dr-> y1 + y_1);
        delay(speed);

        setcolor(WHITE);
        PrintLogs("var -> right = kNode -> right;", 4);
        setcolor(RED);
        line(x2, y2 - y_1, cNode -> dr-> x1, cNode -> dr-> y2 - y_1);
        delay(speed);

        setcolor(WHITE);
        PrintLogs("var -> left = kNode;", 5);
        setcolor(RED);
        line(x1, y1 + y_1, cNode -> x2, cNode -> y1 + y_1);
        delay(speed);

        setcolor(WHITE);
        PrintLogs("kNode -> right = var;", 6);
        setcolor(RED);
        line(x1, y2 - y_1, cNode -> x2, cNode -> y2 - y_1);
        delay(speed);
    }
    setcolor(WHITE);
}
void VisualAddNode_Front(int value, int pos, Nod* cNode)
{
    int x1, x2, y1, y2;
    x1 = PixelsX * 27 / 100;
    y1 = y_10 + (CountNodes()/4 + 1)* (y_3 + y_5);
    x2 = x1 + x_10;
    y2 = y1 + y_3;
    setcolor(RED);
    line(x1, y1, x2, y1);
    line(x1, y1, x1, y2);
    line(x2, y1, x2, y2);
    line(x1, y2, x2, y2);
    line(x1 + x_2, y1, x1 + x_2, y2);
    line(x2 - x_2, y1, x2 - x_2, y2);
    setcolor(WHITE);
    PrintLogs("Nod* var = new Nod;", 1);
    setcolor(RED);
    settextstyle(GOTHIC_FONT, HORIZ_DIR, fontSize);
    char s[6];
    stack <char> stck;
    while(value != 0)
    {
        stck.push(value % 10 + '0');
        value /= 10;
    }
    int i = 0;
    while(!stck.empty())
    {
        s[i++] = stck.top();
        stck.pop();
    }
    s[i] = NULL;
    setcolor(WHITE);
    PrintLogs("var -> info = value;", 2);
    setcolor(RED);
    delay(speed);
    outtextxy(x1 + x_2 + 2, y1 + 1, s);
    delay(speed);
    if(pos == 1)
    {
        Null_Left(x1, y1, x2, y2);
        setcolor(WHITE);
        PrintLogs("var -> left = NULL;", 3);
        setcolor(RED);
        delay(speed);

        line(x2, y1 + y_1, cNode -> x1, cNode -> y1 + y_1);
        setcolor(WHITE);
        PrintLogs("var -> right = kNode;", 4);
        setcolor(RED);
        delay(speed);

        line(x2, y2 - y_1, cNode -> x1, cNode -> y2 - y_1);
        setcolor(WHITE);
        PrintLogs("kNode -> left = var;", 5);
        setcolor(RED);
        delay(speed);

        setcolor(WHITE);
        PrintLogs("frist = var;", 6);
        delay(speed);
    }
    else if(pos == CountNodes() + 1)
    {
        Null_Right(x1, y1, x2, y2);
        setcolor(WHITE);
        PrintLogs("var -> right = NULL;", 3);
        setcolor(RED);
        delay(speed);

        line(x1, y1 + y_1, cNode -> x2, cNode -> y1 + y_1);
        setcolor(WHITE);
        PrintLogs("var -> left = kNode;", 4);
        setcolor(RED);
        delay(speed);

        line(x1, y2 - y_1, cNode -> x2, cNode -> y2 - y_1);
        setcolor(WHITE);
        PrintLogs("kNode -> right = var;", 5);
        setcolor(RED);
        delay(speed);

        setcolor(WHITE);
        PrintLogs("last = var;", 6);
        delay(speed);
    }
    else
    {
        delay(speed);

        line(x1, y1 + y_1, cNode -> st-> x2, cNode -> st-> y1 + y_1);
        setcolor(WHITE);
        PrintLogs("var -> left = kNode -> left;", 3);
        setcolor(RED);
        delay(speed);

        line(x1, y2 - y_1, cNode -> st-> x2, cNode -> st-> y2 - y_1);
        setcolor(WHITE);
        PrintLogs("kNode -> left -> right = var;", 4);
        setcolor(RED);
        delay(speed);

        line(x2, y1 + y_1, cNode -> x1, cNode -> y1 + y_1);
        setcolor(WHITE);
        PrintLogs("kNode -> left = var;", 5);
        setcolor(RED);
        delay(speed);

        line(x2, y2 - y_1, cNode -> x1, cNode -> y2 - y_1);
        setcolor(WHITE);
        PrintLogs("var -> right = kNode;", 6);
        setcolor(RED);
        delay(speed);
    }
    setcolor(WHITE);
}
void InitList()
{
    ft = new Nod;
    lt = new Nod;
    ft -> st = NULL;
    ft -> dr = NULL;
    lt -> st = NULL;
    lt -> dr = NULL;
    ft = lt = NULL;

}
void CreateNode_First(int value)
{
    int x1, x2, y1, y2;
    x1 = x_6;
    y1 = y_10;
    x2 = x_10 + x_6;
    y2 = y_10 + y_3;
    setcolor(RED);
    line(x1, y1, x2, y1);
    line(x1, y1, x1, y2);
    line(x2, y1, x2, y2);
    line(x1, y2, x2, y2);
    line(x1 + x_2, y1, x1 + x_2, y2);
    line(x2 - x_2, y1, x2 - x_2, y2);
    settextstyle(GOTHIC_FONT, HORIZ_DIR, fontSize);
    setcolor(WHITE);
    PrintLogs("Nod* first = new Nod;", 1);
    PrintLogs("Nod* last = new Nod;", 2);
    setcolor(RED);
    char s[6];
    stack <char> stck;
    while(value != 0)
    {
        stck.push(value % 10 + '0');
        value /= 10;
    }
    int i = 0;
    while(!stck.empty())
    {
        s[i++] = stck.top();
        stck.pop();
    }
    s[i] = 0;
    delay(speed);
    outtextxy(x1 + x_2 + 2, y1 + 1, s);
    setcolor(WHITE);
    PrintLogs("first -> info = value;", 3);
    setcolor(RED);
    delay(speed);
    Null_Left(x1, y1, x2, y2);
    setcolor(WHITE);
    PrintLogs("first -> left = NULL;", 4);
    setcolor(RED);
    delay(speed);

    Null_Right(x1, y1, x2, y2);
    setcolor(WHITE);
    PrintLogs("first -> right = NULL;", 5);
    setcolor(RED);
    delay(speed);

    setcolor(WHITE);
    PrintLogs("last = first;", 6);
    setcolor(RED);
    delay(speed);
    setcolor(WHITE);
}
void AddFront(int x)
{
    if(ft == NULL)
    {
        ft = new Nod;
        ft -> info = x;
        ft -> st = NULL;
        ft -> dr = NULL;
        lt = ft;
        CreateNode_First(x);
        return;
    }
    VisualAddNode_Front(x, 1, ft);
    Nod* var = new Nod;
    var -> info = x;
    ft -> st = var;
    var -> dr = ft;
    var -> st = NULL;
    ft = var;
}
void AddBack(int x)
{
    if(lt == NULL)
    {
        lt = new Nod;
        lt -> info = x;
        lt -> st = NULL;
        lt -> dr = NULL;
        ft = lt;
        CreateNode_First(x);
        return;
    }
    VisualAddNode_Back(x, 1, lt);
    Nod* var = new Nod;
    var -> info = x;
    var -> dr = NULL;
    var -> st = lt;
    lt -> dr = var;
    lt = var;
}
void AddKFront(int x, int k)
{
    int i;
    Nod * var = new Nod;
    if(k == 1)
    {
        AddFront(x);
        return;
    }
    if(CountNodes() == k - 1)
    {
        AddBack(x);
        return;
    }
    if(CountNodes() < k - 1 || k <= 0)
    {
        PrintError("Lista nu are destule noduri", 1000);
        return;
    }
    for(i = 1, var = ft; i + 1 < k &&  var -> dr != NULL; i++, var = var ->dr)
        ;
    VisualAddNode_Front(x, k, var->dr);
    Nod* cNode = new Nod;
    cNode -> info = x;
    cNode -> st = var;
    cNode -> dr = var ->dr;
    var -> dr = cNode;
    cNode -> dr -> st = cNode;
}

void AddKBack(int x, int k)
{
    int i;
    Nod * var = new Nod;
    if(k == 1)
    {
        AddBack(x);
        return;
    }
    if(CountNodes() == k - 1)
    {
        AddFront(x);
        return;
    }
    if(CountNodes() < k - 1 || k <= 0)
    {
        PrintError("Lista nu are destule noduri", 1000);
        return;
    }
    for(i = 1, var = lt; i + 1 < k &&  var -> st != NULL; i++, var = var ->st)
        ;
    VisualAddNode_Back(x, k, var->st);
    Nod* cNode = new Nod;
    cNode -> info = x;
    cNode -> dr = var;
    cNode -> st = var ->st;
    var -> st = cNode;
    cNode -> st -> dr = cNode;
}
void VisualDeleteFront(int nNode)
{
    if(nNode == 1)
    {
        setcolor(WHITE);
        PrintLogs("first = first -> right;", 1);
        PrintLogs("first -> left = NULL;", 2);
        setcolor(RED);
        Null_Left(ft -> dr -> x1, ft -> dr ->y1, ft -> dr ->x2, ft -> dr-> y2);
        delay(speed);
        setcolor(WHITE);
        ClearLog(0);
    }
}
void DeleteFront()
{
    if(ft == NULL)
    {
        PrintError("Lista este vida.", 1000);
        return;
    }
    if(CountNodes() > 1) VisualDeleteFront(1);
    if(CountNodes() == 1)
    {
        ft = NULL;
        lt = NULL;
        setcolor(WHITE);
        PrintLogs("first = NULL;", 1);
        PrintLogs("last = NULL;", 2);
        delay(speed);
        return;
    }
    ft = ft -> dr;
    if(ft != NULL)
        ft -> st = NULL;
}
void VisualDeleteBack(int nNode)
{
    if(nNode == 1)
    {
        setcolor(WHITE);
        PrintLogs("last = last -> left;", 1);
        PrintLogs("last -> right = NULL;", 2);
        setcolor(RED);
        Null_Right(lt -> st -> x1, lt -> st ->y1, lt -> st ->x2, lt -> st-> y2);
        delay(speed);
        setcolor(WHITE);
        ClearLog(0);
    }
}
void DeleteBack()
{
    if(lt == NULL)
    {
        PrintError("Lista este vida", 1000);
        return;
    }
    if(CountNodes() > 1) VisualDeleteBack(1);
    if(CountNodes() == 1)
    {
        ft = NULL;
        lt = NULL;
        setcolor(WHITE);
        PrintLogs("first = NULL;", 1);
        PrintLogs("last = NULL;", 2);
        delay(speed);
        return;
    }
    lt = lt -> st;
    if(lt != NULL)
        lt -> dr = NULL;
}
void DeleteKFront(int k)
{
    int i;
    Nod * var = new Nod;
    if(k == 1)
    {
        DeleteFront();
        return;
    }
    if(CountNodes() == k)
    {
        DeleteBack();
        return;
    }
    if(CountNodes() < k || k <= 0)
    {
        PrintError("Lista nu are destule noduri", 1000);
        return;
    }
    for(i = 1, var = ft; i + 1 < k &&  var -> dr != NULL; i++, var = var ->dr)
        ;
    Nod* delNode = new Nod;
    delNode = var -> dr;
    var -> dr = delNode -> dr;
    if(delNode -> dr != NULL)
    {
        delNode -> dr -> st = var;
    }
    delete delNode;
    ///linia nod -> dr
    setcolor(RED);
    line(var -> x2, var->y2 - y_1, var -> dr -> x1, var->dr->y1 + y_1 + y_1);
    delay(speed);
    ///linia nod -> st
    line(var -> x2, var->y2 - 2*y_1, var -> dr -> x1, var->dr->y1 + y_1);
    delay(speed);
    setcolor(WHITE);

}
void DeleteKBack(int k)
{
    int i;
    Nod * var = new Nod;
    if(k == 1)
    {
        DeleteBack();
        return;
    }
    if(CountNodes() == k)
    {
        DeleteFront();
        return;
    }
    if(CountNodes() < k || k <= 0)
    {
        PrintError("Lista nu are destule noduri", 1000);
        return;
    }
    for(i = 1, var = lt; i + 1 < k &&  var -> st != NULL; i++, var = var -> st)
        ;
    Nod* delNode = new Nod;
    delNode = var -> st;
    var -> st = delNode -> st;
    if(delNode -> st != NULL)
    {
        delNode -> st -> dr = var;
    }
    delete delNode;
    ///linia nod -> st
    setcolor(RED);
    line(var -> x1, var->y2 - y_1, var -> st -> x2, var -> st -> y2 - y_1);
    delay(speed);
    ///linia nod -> dr
    line(var -> x1, var->y1 + y_1, var -> st -> x2, var-> st ->y1 + y_1);
    delay(speed);
    setcolor(WHITE);
}
void EditKFront(int k, int x)
{
    if(k < 1 || k > CountNodes())
    {
        PrintError("Lista nu are destule noduri", 1000);
        return;
    }
    if(k == 1)
    {
        ft -> info = x;
        VisualKEdit(x, ft);
        return;
    }
    if(k == CountNodes())
    {
        lt -> info = x;
        VisualKEdit(x, lt);
        return;
    }
    int i;
    Nod * var = new Nod;
    for(i = 1, var = ft; i < k &&  var -> dr != NULL; i++, var = var ->dr)
        ;
    var -> info = x;
    VisualKEdit(x, var);

}
void EditKBack(int k, int x)
{
    if(k < 1 || k > CountNodes())
    {
        PrintError("Lista nu are destule noduri", 1000);
        return;
    }
    if(k == 1)
    {
        lt -> info = x;
        VisualKEdit(x, lt);
        return;
    }
    if(k == CountNodes())
    {
        ft -> info = x;
        VisualKEdit(x, ft);
        return;
    }
    int i;
    Nod * var = new Nod;
    for(i = 1, var = lt; i < k &&  var -> st != NULL; i++, var = var -> st)
        ;
    var -> info = x;
    VisualKEdit(x, var);
}
void CreateNode(int x1, int y1, int x2, int y2, int value)
///stanga sus(x,y), dreapta jos(x,y)
{
    line(x1, y1, x2, y1);
    line(x1, y1, x1, y2);
    line(x2, y1, x2, y2);
    line(x1, y2, x2, y2);
    line(x1 + x_2, y1, x1 + x_2, y2);
    line(x2 - x_2, y1, x2 - x_2, y2);
    settextstyle(GOTHIC_FONT, HORIZ_DIR, fontSize);
    char s[6];
    stack <char> stck;
    while(value != 0)
    {
        stck.push(value % 10 + '0');
        value /= 10;
    }
    int i = 0;
    while(!stck.empty())
    {
        s[i++] = stck.top();
        stck.pop();
    }
    s[i] = 0;
    outtextxy(x1 + x_2 + 2, y1 + 1, s);

}
void InitVisual()
{
    settextstyle(GOTHIC_FONT, HORIZ_DIR, fontSize);
    outtextxy(x_3, y_3, "Liste Dublu Inlantuite");
    line(0, PixelsY * 8 / 100, PixelsX, PixelsY * 8 / 100);
    line(PixelsX * 68 / 100, 0, PixelsX * 68 / 100, PixelsY);
    line(PixelsX * 68 / 100, PixelsY * 60 / 100 -3 , PixelsX, PixelsY * 60 / 100 - 3);

    if(side == 0) setcolor(RED);
    outtextxy(PixelsX * 40 / 100, y_3, "Fata");
    if(side == 0) setcolor(WHITE);
    else setcolor(RED);
    outtextxy(PixelsX * 50 / 100, y_3, "Spate");
    setcolor(WHITE);
    settextstyle(GOTHIC_FONT, HORIZ_DIR, 5);
    outtextxy(PixelsX * 78 / 100, PixelsY * 2 / 100, "Functii");
    outtextxy(PixelsX * 78 / 100, PixelsY * 60 / 100, "Logs");
    line(PixelsX * 68 / 100, PixelsY * 60 / 100 + textheight("Logs") + 2, PixelsX, PixelsY * 60 / 100 + textheight("Logs") + 2);

    settextstyle(GOTHIC_FONT, HORIZ_DIR, fontSize);
    outtextxy(PixelsX * 70 / 100, y_3 + 2*y_5, "Pop");
    outtextxy(PixelsX * 70 / 100, y_3 + 3 * y_5, "Push");
    outtextxy(PixelsX * 70 / 100, y_3 + 4 * y_5, "Delete k element");
    outtextxy(PixelsX * 70 / 100, y_3 + 5 * y_5, "Edit the k element");
    outtextxy(PixelsX * 70 / 100, y_3 + 6 * y_5, "Push a element at k position");
    outtextxy(PixelsX * 70 / 100, y_3 + 7 * y_5, "Print in file");
    outtextxy(PixelsX * 70 / 100, y_3 + 8 * y_5, "Cancel");
    outtextxy(PixelsX * 70 / 100, y_3 + 9 * y_5, "Delay(in ms)");
    outtextxy(PixelsX * 70 / 100, y_3 + 10 * y_5, "Exit");

    ClearLog(0);

    settextstyle(GOTHIC_FONT, HORIZ_DIR, fontSize);
    int ln = 1;
    int nrPerL = 0;
    Nod* var;
    var = ft;
    while(var != NULL)
    {
        if(nrPerL == 4)
        {
            ln++;
            nrPerL = 0;
        }
        nrPerL++;
        int x1, x2, y1, y2;
        x1 = x_6 + (nrPerL - 1) * (x_10 + x_4);
        y1 = y_10 + (ln - 1) * (y_3 + y_5);
        x2 = x_6 + (nrPerL - 1) * (x_10 + x_4) + x_10;
        y2 = y_10 + (ln - 1) * (y_3 + y_5) + y_3;
        CreateNode(x1, y1, x2, y2, var -> info);
        var -> x1 = x1; var -> y1 = y1;
        var -> x2 = x2; var -> y2 = y2;
        if(nrPerL < 4 && var->dr != NULL)
        {
            setcolor(GREEN);
            line(x2, y2 - y_1, x2 + x_4, y2 - y_1);
        }

        if(nrPerL < 4 && var->dr != NULL)
        {
            setcolor(YELLOW);
            line(x2, y1 + y_1, x2 + x_4, y1 + y_1);
        }
        if(nrPerL == 4 && var -> dr != NULL)
        {
            setcolor(GREEN);
            line(x2, y2 - y_1, x2 + x_2, y2 - y_1);
            line(x2 + x_2, y2 - y_1, x2 + x_2, y2 - y_1 + y_3);
            line(x_4, y_10 + ln * (y_3 + y_5) - y_3, x2 + x_2, y2 - y_1 + y_3);
            line(x_4, y_10 + ln * (y_3 + y_5) - y_3, x_4, y_10 + ln * (y_3 + y_5) - y_3 + y_5);
            line(x_4, y_10 + ln * (y_3 + y_5) + y_3 - y_1, x_6, y_10 + ln * (y_3 + y_5) + y_3 - y_1);
            setcolor(YELLOW);
            line(x2, y1 + y_1, x2 + x_1, y1 + y_1);
            line(x2 + x_1, y1 + y_1, x2 + x_2 - x_1, y2  + y_3);
            line(x_4 + x_1, y_10 + ln * (y_3 + y_5) - y_3 + y_1, x2 + x_2 - x_1, y2  + y_3);
            line(x_6 - x_1, y_1 + y_10 + ln * (y_3 + y_5), x_4 + x_1, y_10 + ln * (y_3 + y_5) - y_3 + y_1);
            line(x_6,  y_1 + y_10 + ln * (y_3 + y_5), x_6 - x_1, y_1 +y_10 + ln * (y_3 + y_5));
        }
        if(var -> st == NULL)
        {
            setcolor(YELLOW);
            Null_Left(x1, y1, x2, y2);
        }
        if(var -> dr == NULL)
        {
            setcolor(GREEN);
            Null_Right(x1, y1, x2, y2);
        }
        setcolor(WHITE);
        var = var -> dr;
    }
}
bool CheckClickedFront()
{
    if(mousex() > PixelsX * 40 / 100 && mousex() < PixelsX * 40 / 100 + x_10 && mousey() > y_3 && mousey() < y_5 && ismouseclick(WM_LBUTTONDOWN))
    {
        clearmouseclick(WM_LBUTTONDOWN);
        return true;
    }
    return false;
}
bool CheckClickedBack()
{
    if(mousex() > PixelsX * 50 / 100 && mousex() < PixelsX * 50 / 100 + x_10 && mousey() > y_3 && mousey() < y_5 && ismouseclick(WM_LBUTTONDOWN))
    {
        clearmouseclick(WM_LBUTTONDOWN);
        return true;
    }
    return false;
}
bool CheckClickedPop()
{
    if(mousex() > PixelsX * 70 / 100 && mousex() < PixelsX * 70 / 100 + x_6 && mousey() > y_3 + 2*y_5 && mousey() < y_3 + 2*y_5 + y_3 && ismouseclick(WM_LBUTTONDOWN))
    {
        clearmouseclick(WM_LBUTTONDOWN);
        return true;
    }
    return false;
}
bool CheckClickedPush()
{
    if(mousex() > PixelsX * 70 / 100 && mousex() < PixelsX * 70 / 100 + x_6 && mousey() > y_3 + 3*y_5 && mousey() < y_3 + 3*y_5 + y_3 && ismouseclick(WM_LBUTTONDOWN))
    {
        clearmouseclick(WM_LBUTTONDOWN);
        return true;
    }
    return false;
}
bool CheckClickedDeleteK()
{
    if(mousex() > PixelsX * 70 / 100 && mousex() < PixelsX * 85 / 100  && mousey() > y_3 + 4*y_5 && mousey() < y_3 + 4*y_5 + y_3 && ismouseclick(WM_LBUTTONDOWN))
    {
        clearmouseclick(WM_LBUTTONDOWN);
        return true;
    }
    return false;
}
bool CheckClickedEditK()
{
    if(mousex() > PixelsX * 70 / 100 && mousex() < PixelsX * 87 / 100  && mousey() > y_3 + 5*y_5 && mousey() < y_3 + 5*y_5 + y_3 && ismouseclick(WM_LBUTTONDOWN))
    {
        clearmouseclick(WM_LBUTTONDOWN);
        return true;
    }
    return false;
}
bool CheckClickedEditK_1()///pentru k
{
    if(mousex() > PixelsX * 70 / 100 && mousex() < PixelsX * 70 / 100 + x_1 && mousey() > y_3 + 5*y_5 && mousey() < y_3 + 5*y_5 + y_3 && ismouseclick(WM_LBUTTONDOWN))
    {
        clearmouseclick(WM_LBUTTONDOWN);
        return true;
    }
    return false;
}
bool CheckClickedEditK_2()///pentru value
{
    if(mousex() > PixelsX * 85 / 100 && mousex() < PixelsX * 95 / 100 && mousey() > y_3 + 5*y_5 && mousey() < y_3 + 5*y_5 + y_3 && ismouseclick(WM_LBUTTONDOWN))
    {
        clearmouseclick(WM_LBUTTONDOWN);
        return true;
    }
    return false;
}
bool CheckClickedPushK()
{
    if(mousex() > PixelsX * 70 / 100 && mousex() < PixelsX * 87 / 100  && mousey() > y_3 + 6*y_5 && mousey() < y_3 + 6*y_5 + y_3 && ismouseclick(WM_LBUTTONDOWN))
    {
        clearmouseclick(WM_LBUTTONDOWN);
        return true;
    }
    return false;
}
bool CheckClickedPushK_1()///pentru k
{
    if(mousex() > PixelsX * 70 / 100 && mousex() < PixelsX * 70 / 100 + x_1 && mousey() > y_3 + 6*y_5 && mousey() < y_3 + 6*y_5 + y_3 && ismouseclick(WM_LBUTTONDOWN))
    {
        clearmouseclick(WM_LBUTTONDOWN);
        return true;
    }
    return false;
}
bool CheckClickedPushK_2()///pentru value
{
    if(mousex() > PixelsX * 85 / 100 && mousex() < PixelsX * 95 / 100 && mousey() > y_3 + 6*y_5 && mousey() < y_3 + 6*y_5 + y_3 && ismouseclick(WM_LBUTTONDOWN))
    {
        clearmouseclick(WM_LBUTTONDOWN);
        return true;
    }
    return false;
}
bool CheckClickedCancel()
{
    if(mousex() > PixelsX * 70 / 100 && mousex() < PixelsX * 70 / 100 + x_10 && mousey() > y_3 + 8*y_5 && mousey() < y_3 + 8*y_5 + y_3 && ismouseclick(WM_LBUTTONDOWN))
    {
        clearmouseclick(WM_LBUTTONDOWN);
        return true;
    }
    return false;
}
bool CheckClickedDelay()
{
    if(mousex() > PixelsX * 70 / 100 && mousex() < PixelsX * 70 / 100 + x_10 && mousey() > y_3 + 9*y_5 && mousey() < y_3 + 9*y_5 + y_3 && ismouseclick(WM_LBUTTONDOWN))
    {
        clearmouseclick(WM_LBUTTONDOWN);
        return true;
    }
    return false;
}
bool CheckClickedPrintInFile()
{
    if(mousex() > PixelsX * 70 / 100 && mousex() < PixelsX * 83 / 100 && mousey() > y_3 + 7*y_5 && mousey() < y_3 + 7*y_5 + y_3 && ismouseclick(WM_LBUTTONDOWN))
    {
        clearmouseclick(WM_LBUTTONDOWN);
        return true;
    }
    return false;
}

bool CheckClickedExit()
{
    if(mousex() > PixelsX * 70 / 100 && mousex() < PixelsX * 70 / 100 + x_10 && mousey() > y_3 + 10*y_5 && mousey() < y_3 + 10*y_5 + y_3 && ismouseclick(WM_LBUTTONDOWN))
    {
        clearmouseclick(WM_LBUTTONDOWN);
        return true;
    }
    return false;
}

int GetValueOnScreen(int x, int y, int x2, int maxNumberOfD)
{
    while(kbhit()) getch();
    setfillstyle(SOLID_FILL, BLACK);
    bar(x, y, x2, y + y_3);
    int a = 0;
    char str[16] = {NULL};
    int cnt = 0;
    int nr = 0;

    a = getch();
    while(true)
    {
        if(a == 8)
        {
            if(nr == 0)
            {
                PrintError("Nu ai ce sterge!", 1000);
                a = getch();
                continue;
            }
            nr /= 10;
            cnt--;
            str[cnt] = 0;
            bar(x, y, x2, y + y_3);
            outtextxy(x, y, str);
            a = getch();
            continue;
        }
        if(cnt > maxNumberOfD)
        {
            PrintError("Ai depasit numarul maxim de cifre!", 1000);
            a = getch();
            continue;
        }
        if(a == 13)
        {
            if(cnt == 0)
            {
                PrintError("Nu ai introdus vreo valoare!", 1000);
                a = getch();
                continue;
            }
            else break;
        }
        if((a < '0' || a > '9') && a != 0)
        {
            PrintError("Numarul trebuie sa fie format doar din cifre!", 1000);
            a = getch();
            continue;
        }
        str[cnt++] = a;
        nr = nr * 10 + a - '0';
        str[cnt] = 0;
        outtextxy(x, y, str);
        a = getch();
    }
    return nr;
}
void AddElement()
{
    if(CountNodes() == 40)
    {
        PrintError("Ai atins limita de 40 de noduri!", 1000);
        return;
    }
    int nr = GetValueOnScreen(PixelsX * 70 / 100, y_3 + 3*y_5, PixelsX, 5);
    if(side == 0) AddFront(nr);
    else AddBack(nr);
}

void DeleteKElement()
{
    int k =  GetValueOnScreen(PixelsX * 70 / 100, y_3 + 4*y_5, PixelsX, 2);
    if(k > CountNodes())
    {
        PrintError("Lista nu are destule noduri!", 1000);
    }
    if(side == 0) DeleteKFront(k);
    else DeleteKBack(k);
}

void EditKElement()
{
    setfillstyle(SOLID_FILL, BLACK);
    bar(PixelsX * 70 / 100, y_3 + 5*y_5, PixelsX, y_3 + 5*y_5 + y_3);
    outtextxy(PixelsX * 70 / 100, y_3 + 5*y_5, "K");
    outtextxy(PixelsX * 85/100, y_3 + 5*y_5, "Value");
    int k = 0, value = 0;
    while(k == 0 || value == 0)
    {
        if(CheckClickedCancel() == true)
            return;
        if(CheckClickedEditK_1() == true)
        {
            k = GetValueOnScreen(PixelsX * 70 / 100, y_3 + 5*y_5, PixelsX * 85/100 - 2, 2);
            if(k > CountNodes())
            {
                PrintError("Lista nu are destule noduri!", 1000);
                k = 0;
                bar(PixelsX * 70 / 100, y_3 + 5*y_5, PixelsX * 85/100 - 2 , y_3 + 5*y_5 + y_3);
                outtextxy(PixelsX * 70 / 100, y_3 + 5*y_5, "K");
            }
        }
        if(CheckClickedEditK_2() == true)
        {
            value = GetValueOnScreen(PixelsX * 85/100, y_3 + 5*y_5, PixelsX, 5);
        }
    }
    if(side == 0) EditKFront(k, value);
    else EditKBack(k, value);
}
void PushKElement()
{
    if(CountNodes() > 40)
    {
        PrintError("Lista a atins numarul maxim de noduri!", 1000);
        return;
    }
    setfillstyle(SOLID_FILL, BLACK);
    bar(PixelsX * 70 / 100, y_3 + 6*y_5, PixelsX, y_3 + 6*y_5 + y_3);
    outtextxy(PixelsX * 70 / 100, y_3 + 6*y_5, "K");
    outtextxy(PixelsX * 85/100, y_3 + 6*y_5, "Value");
    int k = 0, value = 0;
    while(k == 0 || value == 0)
    {
        if(CheckClickedCancel() == true)
            return;
        if(CheckClickedPushK_1() == true)
        {
            k = GetValueOnScreen(PixelsX * 70 / 100, y_3 + 6*y_5, PixelsX * 85/100 - 2, 2);
            if(k - 1 > CountNodes())
            {
                PrintError("Lista nu are destule noduri!", 1000);
                k = 0;
                bar(PixelsX * 70 / 100, y_3 + 6*y_5, PixelsX * 85/100 - 2 , y_3 + 6*y_5 + y_3);
                outtextxy(PixelsX * 70 / 100, y_3 + 6*y_5, "K");
            }
        }
        if(CheckClickedPushK_2() == true)
        {
            value = GetValueOnScreen(PixelsX * 85/100, y_3 + 6*y_5, PixelsX, 5);
        }
    }
    if(side == 0) AddKFront(value, k);
    else AddKBack(value, k);
}
void ClickInit()
{
    cleardevice();
    InitVisual();
}
void PrintListInFile()
{
    ofstream fout ("doublelist.out");
    Nod* var = new Nod;
    var = ft;
    if(ft == NULL)
    {
        fout << "Lista vida!";
        fout.close();
        return;
    }
    while(var != NULL)
    {
        if(var != ft && var != lt)
        {
            fout << " <-> ";
        }
        fout << var -> info;
        var = var -> dr;
    }
    fout.close();
}
void ChangeDelay()
{
    setfillstyle(SOLID_FILL, BLACK);
    bar(PixelsX * 70 / 100, y_3 + 9*y_5, PixelsX, y_3 + 9*y_5 + y_3);
    speed = GetValueOnScreen(PixelsX * 70 / 100, y_3 + 9*y_5, PixelsX, 8);
}
void DoubleListInit(bool & mainliste, bool & listeduble)
{
    PixelsX  = x;
    PixelsY  = y;
    setcolor(WHITE);
    setbkcolor(0);

    x_1 = PixelsX * 1 / 100, x_2 = PixelsX * 2 / 100, x_3 = PixelsX * 3 / 100, x_4 = PixelsX * 4 / 100, x_6 = PixelsX * 6 / 100, x_10 = PixelsX * 10 / 100;
    y_1 = PixelsY * 1 / 100, y_3 = PixelsY * 3 / 100, y_5 = PixelsY * 5 / 100, y_10 = PixelsY * 10 / 100;
    //initwindow(PixelsX, PixelsY, "Liste Dublu Inlantuite");
    cleardevice();
    fontSize = GetFontSize("999999", y_3 - 3 , y_3 -3);
    settextstyle(0, 0, fontSize);
    InitList();
    InitVisual();

    int op; /// 1 = pop_back; 2 = pop_front; 3 = pop_k_front
    while(listeduble == true)
    {
        if(ismouseclick(WM_LBUTTONDOWN))
        {
            if(CheckClickedFront() == true)
            {
                side = 0;
                ClickInit();
            }
            if(CheckClickedBack() == true)
            {
                side = 1;
                ClickInit();
            }
            if(CheckClickedPop() == true)
            {
                if(side == 0) DeleteFront();
                else DeleteBack();
                ClickInit();
            }
            if(CheckClickedPush() == true)
            {
                AddElement();
                ClickInit();
            }
            if(CheckClickedDeleteK() == true)
            {
                DeleteKElement();
                ClickInit();
            }
            if(CheckClickedEditK() == true)
            {
                EditKElement();
                ClickInit();
            }
            if(CheckClickedPushK() == true)
            {
                PushKElement();
                ClickInit();
            }
            if(CheckClickedPrintInFile() == true)
            {
                PrintListInFile();
                ClickInit();
            }
            if(CheckClickedDelay() == true)
            {
                ChangeDelay();
                ClickInit();
            }
            if(CheckClickedExit() == true)
            {
                mainliste = true;
                listeduble = false;
                cleardevice();
                readimagefile("JPG/main_Liste.jpg",0,0,PixelsX,PixelsY);
            }
            clearmouseclick(WM_LBUTTONDOWN);
        }
    }
}
