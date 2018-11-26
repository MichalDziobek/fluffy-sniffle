from tkinter import *

from pyswip import Prolog
prolog = Prolog()
prolog.consult("../rules.pl")
places = [x['Y'] for x in list(prolog.query("adjective(relaxing,Y)"))]


def callback():
        print("click !")

class App:

    def __init__(self, master):
        left_frame = Frame(master)
        left_frame.pack(side=LEFT)
        right_frame = Frame(master)
        right_frame.pack(side=RIGHT)
        self.show_relaxing = Button(right_frame, text="Relaxing", command=lambda: self.list_adjective("relaxing"))
        self.show_relaxing.grid(row=0)
        self.show_snobbish = Button(right_frame, text="Snobbish", command=lambda: self.list_adjective("snobbish"))
        self.show_snobbish.grid(row=1)
        self.show_creative = Button(right_frame, text="Creative", command=lambda: self.list_adjective("creative"))
        self.show_creative.grid(row=2)
        self.list_box = Listbox(left_frame)
        self.list_box.pack()

    def say_hi(self):
        print("hi there, everyone!")

    def list_adjective(self,adjective):
        self.list_box.delete(0, END)
        [self.list_box.insert(END, x['Y']) for x in list(prolog.query("adjective(%s,Y)" % adjective))]



root = Tk()
root.title("The concierge")
root.geometry("800x600")
root.resizable(0,0)
app = App(root)
root.mainloop()


