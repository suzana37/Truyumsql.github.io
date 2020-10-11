1. View Menu Item List Admin (TYUC001)

create table menu(
id integer primary key,

name varchar(20),

price decimal(5,2),

active varchar(3),

date_of_launch date,

category varchar(20),

freedelivery varchar(3)
);

/* Frame insert scripts to add data into menu_item table. Refer View Menu
Item List Admin screen below for sample data.*/

insert into menu(id,name,price,active,date_of_launch,category,freedelivery) values(1, "Sandwitch",99.00,"yes","2017/03/15","Main course","Yes");

insert into menu(id,name,price,active,date_of_launch,category,freedelivery) values(2, "Burger",129.00,"yes","2017/12/23","Main course","No");

insert into menu(id,name,price,active,date_of_launch,category,freedelivery) values(3,'Pizza','149.00','Yes','2017/08/21','main Course','No');

insert into menu(id,name,price,active,date_of_launch,category,freedelivery) values(4,'French Fries','57.00','No','2017/07/02','Starters','Yes');

insert into menu(id,name,price,active,date_of_launch,category,freedelivery) values(5,'Chocolate Brownie','32.00','Yes','2022/11/02','Desert','Yes');



/* Frame SQL query to get all menu items*/

select * from menu;

output

id	name	price	active	date_of_launch	category	freedelivery
1	Sandwitch	99.00	yes	2017-03-15	Main course	Yes
2	Burger	129.00	yes	2017-12-23	Main course	No
3	Pizza	149.00	Yes	2017-08-21	main Course	No
4	French Fries	57.00	No	2017-07-02	Starters	Yes
5	Chocolate Brownie	32.00	Yes	2022-11-02	Desert	Yes

2. View Menu Item List Customer (TYUC002)

/* Frame SQL query to get all menu items which after launch date and is
active.*/

select * from menu where active="yes" and date_of_launch < '2020/01/01';

id	name	price	active	date_of_launch	category	freedelivery
1	Sandwitch	99.00	yes	2017-03-15	Main course	Yes
2	Burger	129.00	yes	2017-12-23	Main course	No
3	Pizza	149.00	Yes	2017-08-21	main Course	No

3. Edit Menu Item (TYUC003)

/* Frame SQL query to get a menu items based on Menu Item Id*/

select * from menu where id=3;

id	name	price	active	date_of_launch	category	freedelivery
3	Pizza	149.00	Yes	2017-08-21	main Course	No

/* Frame update SQL menu_items table to update all the columns values
based on Menu Item Id*/

update menu set name='Donut',price=35.00,active='yes',date_of_launch='2017/11/9',category='dessert',freedelivery='no' where id=5;
select * from menu where id=5;


id	name	price	active	date_of_launch	category	freedelivery
5	Donut	35.00	yes	2017-11-09	dessert	no



4. Add to Cart (TYUC004)

/*Frame insert scripts for adding data into user and cart tables.In user table
create two users. Once user will not have any entries in cart, while the
other will have at least 3 items in the cart.*/

create table users(

user_id int primary key,

name varchar(20),
menu_id int ,

foreign key(menu_id) references menu(id)

);

create table cart(

cart_id int Auto_increment primary key,

menu_id int,

foreign key(menu_id) references menu(id),

user_id int,
foreign key(user_id) references users(user_id)
);


insert into users(user_id,name)values(101,"sam"),(144,"sonu");

select * from users;


insert into cart(user_id,menu_id)values(101,1),(101,2),(101,3),(144,null);

select * from cart;


user_id	name	menu_id
101	sam	NULL
144	sonu	NULL
cart_id	menu_id	user_id
1	1	101
2	2	101
3	3	101
4	NULL	144

5. View Cart (TYUC005)

/*Frame SQL query to get all menu items in a particular user’s cart*/

Select m.name,m.price,m.date_of_launch,m.category,m.freedelivery from menu as m inner join cart as c on m.id=c.menu_id where c.user_id=101;


name	price	date_of_launch	category	freedelivery
Sandwitch	99.00	2017-03-15	Main course	Yes
Burger	129.00	2017-12-23	Main course	No
Pizza	149.00	2017-08-21	main Course	No

/* Frame SQL query to get the total price of all menu items in a particular
user’s cart*/


select sum(price) as totalprice from menu as m inner join cart as c on m.id=c.menu_id inner join users as u on u.user_id=c.user_id where u.user_id=101;


totalprice
377.00


6. Remove Item from Cart (TYUC006)

/* Frame SQL query to remove a menu items from Cart based on User Id
and Menu Item Id*/


delete from cart where user_id='101' and menu_id='2';

select * from cart;


cart_id	menu_id	user_id
1	1	101
3	3	101
4	NULL	144
