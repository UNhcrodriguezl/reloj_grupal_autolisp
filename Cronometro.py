from tkinter import *

global count
global r 
r = 0
count =0  
def reset():
    global count
    count=1
    t.set('00:00:00')
    
def start():
    global count
    count=0
    timer()

def start_timer():
    global count
    timer()

def stop():
    global count
    global r
    d = str(t.get())
    count=1
    file = open("tiempo.txt" , "w")
    file.write(d)
    root.quit()
    

def timer():
    global count
    if(count==0):
        d = str(t.get())
        h,m,s = map(int,d.split(":"))
        
        h = int(h)
        m=int(m)
        s= int(s)
        if s == 0.0:
            t.set(d)
        if(s<59):
            s+=1
        elif(s==59):
            s=0
            if(m<59):
                m+=1
            elif(m==59):
                h+=1
        if(h<10):
            h = str(0)+str(h)
        else:
            h= str(h)
        if(m<10):
            m = str(0)+str(m)
        else:
            m = str(m)
        if(s<10):
            s=str(0)+str(s)
        else:
            s=str(s)
        d=h+":"+m+":"+s
        
        
        t.set(d)
        if(count==0):
            root.after(930,start_timer)
        
    
root=Tk()
root.title("Stop Watch")
root.geometry("300x175")       #TAMAÑO DE LA VENTANA
root.resizable(False,False)
t = StringVar()
t.set("00:00:00")
lb = Label(root,textvariable=t)
lb.config(font=("Courier 40 bold"))                
bt1 = Button(root,text="Start",command=start,font=("Courier 12 bold"))
bt2 = Button(root,text="Stop",command=stop,font=("Courier 12 bold"))
if r == 1:
    root.quit()
lb.place(x=20,y=25)
bt1.place(x=25,y=100)
bt2.place(x=225,y=100)
    
root.mainloop()