from tkinter import *

from pyswip import Prolog
prolog = Prolog()
prolog.consult("../rules.pl")

class App:

    def __init__(self, master):
        self.master = master
        self.queries = {}
        left_frame = Frame(master)
        left_frame.pack(side=LEFT)
        center_frame = Frame(master)
        center_frame.pack(side=LEFT,padx=100,pady=100)
        right_frame = Frame(master)
        right_frame.pack(side=RIGHT)
        self.map = {
            'PY_VAR0': 'drink',
            'PY_VAR1': 'food',
            'PY_VAR2': 'payment',
            'PY_VAR3': 'distance',
            'PY_VAR4': 'type',
            'PY_VAR5': 'price',
            'PY_VAR6': 'accessibility',
            'PY_VAR7': 'amenity',
            'PY_VAR8': 'ambiance',
            'PY_VAR9': 'theme'
        }
        self.buttons = []
        self.add_buttons(right_frame)
        self.render_buttons()
        self.option_menus = []
        self.add_option_menus(center_frame)
        self.render_option_menus()
        self.recommendations_label = Label(left_frame, text="Recommendations:")
        self.recommendations_label.pack()
        self.list_box = Listbox(left_frame)
        self.list_box.pack()
        self.reset = Button(left_frame,text="Reset",command=self.reset)
        self.reset.pack()
        print(self.reset.config('text')[-1])

    def map_tkvar(self,value):
        return self.map.get(value,None)

    def add_option_menu(self,frame,label,value_list):
        tkvar = StringVar(self.master)
        tkvar.set('')
        tkvar.trace('w',self.change_dropdown)
        label = Label(frame,text=label)
        menu = OptionMenu(frame,tkvar,*value_list)

        self.option_menus.append((label,menu))

    def add_option_menus(self,frame):
        drinks = ['', 'champagne', 'whiskey', 'vodka', 'bourbon', 'beer', 'wine', 'tea', 'coffe', 'drinks', 'soda',
                  'rum', 'gin', 'coctail', 'lemonade', 'juice']
        drinks.sort()
        food = ['', 'cheese', 'mexican', 'vegan', 'vegetarian', 'european', 'modern', 'dessert', 'breakfast', 'cake',
                'burger', 'sandwich', 'pizza', 'italian', 'traditional']
        food.sort()
        payment = ['', 'cash', 'card']
        distance = ['', 'not_far', 'near', 'far']
        type = ['', 'museum', 'excape_room', 'cafe', 'restaurant', 'theater', 'spa']
        price = ['', 'cheap', 'moderate', 'expensive']
        accessibility = ['', 'wheelchair']
        amenity = ['', 'wifi', 'jakuzzi', 'sauna', 'fireplace']
        ambiance = ['', 'cosy', 'casual', 'classical', 'kids_friendly']
        theme = ['', 'industrail', 'etnographic', 'japanese', 'jewish', 'holocaust', 'mars', 'nuclear', 'oriental',
                 'acient_mystery']
        self.add_option_menu(frame,"Drink:",drinks)
        self.add_option_menu(frame,"Food:",food)
        self.add_option_menu(frame,"Payment:",payment)
        self.add_option_menu(frame,"Distance:",distance)
        self.add_option_menu(frame,"Type:",type)
        self.add_option_menu(frame,"Price:",price)
        self.add_option_menu(frame,"Accessibility:",accessibility)
        self.add_option_menu(frame,"Amenity:",amenity)
        self.add_option_menu(frame,"Ambiance:",ambiance)
        self.add_option_menu(frame,"Theme:",theme)

    def render_option_menus(self):
        for index in range(len(self.option_menus)):
            self.option_menus[index][0].grid(row=index,column=0)
            self.option_menus[index][1].grid(row=index,column=1)

    def change_dropdown(self,*args):
        value =  self.master.getvar(args[0])
        if value == '':
            self.delete_query(args[0])
            return
        self.add_query(args[0],self.get_query(self.map_tkvar(args[0]),value))
        self.run_query()

    def add_button(self,frame,text,function,value):
        button = Button(frame,text=text,command=lambda: self.handle_button_click(button,function,value))
        self.buttons.append(button)

    def add_buttons(self,frame):
        self.add_button(frame,"Relaxing","adjective","relaxing")
        self.add_button(frame,"Snobbish","adjective","snobbish")
        self.add_button(frame,"Creative","adjective","creative")
        self.add_button(frame,"Drinking","activity","drinking")
        self.add_button(frame,"Eating","activity","eating")
        self.add_button(frame,"Resting","activity","resting")
        self.add_button(frame,"Sightseeing","activity","sightseeing")

    def render_buttons(self):
        for index in range(len(self.buttons)): self.buttons[index].grid(row=index)

    def handle_button_click(self,button,type,value):
        key = button.config('text')[-1]
        if button.config('relief')[-1] == 'sunken':
            self.delete_query(key)
            button.config(relief='raised')
        else:
            button.config(relief='sunken')
            self.add_query(key,self.get_query(type,value))
        self.run_query()

    def add_query(self,name,query):
        self.queries[name] = query

    def delete_query(self,name):
        if name in self.queries:
            del self.queries[name]

    def get_query(self,type,value):
        return "%s(%s,Y)" % (type,value)

    def run_query(self):
        self.list_box.delete(0,END)
        query = ', '.join(self.queries.values())
        if query != '':
            print('Current query: ' + query)
            pois = set([poi['Y'] for poi in prolog.query(query)])
            self.list_box.insert(END,*pois)

    def toggle(self,button):
        if button.config('relief')[-1] == 'sunken':
            button.config(relief='raised')
        else:
            button.config(relief='sunken')

    def reset(self):
        for button in self.buttons:
            button.config(relief='raised')
        for var_name in self.map:
            self.master.setvar(var_name,'')
        self.list_box.delete(0,END)
        self.queries.clear()


root = Tk()
root.title("The concierge")
root.geometry("800x600")
root.resizable(0,0)
app = App(root)
root.mainloop()


