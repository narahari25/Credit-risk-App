import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Person {
  final int id;
  final String name;
  final String imageURL;
  final String phoneNumber;
  final String email;
  final int idType;
  final String cardNum;
  final double creditScore;
  final String salary;
  final String age;
  final String dependents;


  Person(
    {required this.name, 
    required this.phoneNumber, 
    this.imageURL = "images/4",
    required this.id,
    required this.email,
    required this.idType,
    required this.cardNum,
    required this.salary,
    required this.age,
    required this.dependents,
    this.creditScore = 0
    ,}
    ); 

}

Person me = Person(
  id: 1,
  name: 'Aisha Harris',
  imageURL: 'images/pfp.jpg',
  phoneNumber: '+91 8287094343',
  email: "a@gmail.com",
  idType: 0,
  cardNum: "0000111122223333",
  creditScore: 0,
  salary: '1',
  age:'19',
  dependents: '2'
);


Person them = Person(
  id: -1,
  name: 'Parvati Patil',
  imageURL: 'images/2',
  phoneNumber: '+918639592376',
  email: "gryffingirls@gmail.com",
  idType: 1,
  cardNum: "234258837293",
  creditScore: 3.7,
  salary: '10000',
  age:'19',
  dependents: '2'
);
double credit = 0;
List<Person> ongtransactions = [ people[0],people[1],people[2], people[3], people[4], people[5], people[6], people[7], people[8], people[9], people[10], people[11], people[13]];

List<Person> comtransactions = [ people[14], people[15], people[18]];
int ongTransactionCount = ongtransactions.length;
int comTransactionCount = comtransactions.length;
 
List<Person> people = [
  Person(
    id: 1,
    name: 'Luella Manning',
    imageURL: 'images/1.jpg',
    phoneNumber: '(+91) 893 495 3243',
    email: "luellamanning@gmail.com",
    idType: 0,
    cardNum: "123456789012",
    creditScore: credit,
    salary: '10000',
    age:'19',
    dependents: '2'
  ),
  Person(
    id: 2,
    name: 'Turner Reilly',
    imageURL: 'images/2.jpg',
    phoneNumber: '(+91) 893 425 3243',
    email: "turnerreilly@gmail.com",
    idType: 1,
    cardNum: "987654321098",
    creditScore: credit,
    salary: '10000',
    age:'19',
    dependents: '2'
  ),
  Person(
    id: 3,
    name: 'Appie Doe',
    imageURL: 'images/3.jpg',
    phoneNumber: '(+91) 242 495 2982',
    email: "appiedoe@gmail.com",
    idType: 0,
    cardNum: "234567890123",
    creditScore: 2.5,
    salary: '10000',
    age:'19',
    dependents: '2'
  ),
  Person(
    id: 4,
    name: 'Ember Flynn',
    imageURL: 'images/4.jpg',
    phoneNumber: '(+91) 534 585 6123',
    email: "emberflynn@gmail.com",
    idType: 1,
    cardNum: "456789012345",
    creditScore: 6,
    salary: '10000',
  age:'19',
  dependents: '2'
  ),
  Person(
    id: 5,
    name: 'Tara Doe',
    imageURL: 'images/5.jpg',
    phoneNumber: '(+91) 152 495 3243',
    email: "taradoe@gmail.com",
    idType: 0,
    cardNum: "890123456789",
    creditScore: -3,
    salary: '10000',
  age:'19',
  dependents: '2'
  ),
  Person(
    id: 6,
    name: 'Joziah Hayden',
    imageURL: 'images/6.jpg',
    phoneNumber: '(+91) 835 495 3243',
    email: "joziahhayden@gmail.com",
    idType: 1,
    cardNum: "567890123456",
    creditScore: 1,
    salary: '10000',
  age:'19',
  dependents: '2'
  ),
  Person(
    id: 7,
    name: 'Pratheep Doe',
    imageURL: 'images/7.jpg',
    phoneNumber: '(+91) 343 495 3243',
    email: "pratheepdoe@gmail.com",
    idType: 0,
    cardNum: "901234567890",
    creditScore: 4,
    salary: '10000',
  age:'19',
  dependents: '2'
  ),
  Person(
    id: 8,
    name: 'Manmohan Smith',
    imageURL: 'images/8.jpg',
    phoneNumber: '(+91) 580 495 3243',
    email: "manmohansmith@gmail.com",
    idType: 1,
    cardNum: "678901234567",
    creditScore: -2,
    salary: '10000',
  age:'19',
  dependents: '2'
  ),
  Person(
    id: 9,
    name: 'Evelyn Walters',
    imageURL: 'images/9.jpg',
    phoneNumber: '(+91) 888 363 32433)',
    email: "evelynwalters@gmail.com",
    idType: 0,
    cardNum: "123456789012",
    creditScore: 5,
    salary: '10000',
  age:'19',
  dependents: '2'
  ),
  Person(
    id: 10,
    name: 'Aarav Patel',
    imageURL: 'images/10.jpg',
    phoneNumber: '(+91) 999 888 7777',
    email: "aaravpatel@gmail.com",
    idType: 1,
    cardNum: "012345678901",
    creditScore: 2,
    salary: '10000',
  age:'19',
  dependents: '2'
  ),
  Person(
    id: 11,
    name: 'Ishaan Gupta',
    imageURL: 'images/11.jpg',
    phoneNumber: '(+91) 777 888 9999',
    email: "ishaangupta@gmail.com",
    idType: 0,
    cardNum: "123456789012",
    creditScore: -1.5,
    salary: '10000',
  age:'19',
  dependents: '2'
  ),
  Person(
    id: 12,
    name: 'Riya Singh',
    imageURL: 'images/12.jpg',
    phoneNumber: '(+91) 888 777 9999',
    email: "riyasingh@gmail.com",
    idType: 1,
    cardNum: "234567890123",
    creditScore: 4,
    salary: '10000',
  age:'19',
  dependents: '2'
  ),
  Person(
    id: 13,
    name: 'Arjun Sharma',
    imageURL: 'images/13.jpg',
    phoneNumber: '(+91) 777 999 8888',
    email: "arjunsharma@gmail.com",
    idType: 0,
    cardNum: "345678901234",
    creditScore: 1,
    salary: '10000',
  age:'19',
  dependents: '2'
  ),
  Person(
    id: 14,
    name: 'Aanya Khan',
    imageURL: 'images/14.jpg',
    phoneNumber: '(+91) 888 999 7777',
    email: "aanyakhan@gmail.com",
    idType: 1,
    cardNum: "456789012345",
    creditScore: 3.5,
    salary: '10000',
  age:'19',
  dependents: '2'
  ),
  Person(
    id: 15,
    name: 'Vihaan Reddy',
    imageURL: 'images/15.jpg',
    phoneNumber: '(+91) 999 777 8888',
    email: "vihaanreddy@gmail.com",
    idType: 0,
    cardNum: "567890123456",
    creditScore: -2,
    salary: '10000',
  age:'19',
  dependents: '2'
  ),
  Person(
    id: 16,
    name: 'Saisha Mehra',
    imageURL: 'images/16.jpg',
    phoneNumber: '(+91) 777 888 9999',
    email: "saishamehra@gmail.com",
    idType: 1,
    cardNum: "678901234567",
    creditScore: 0,
    salary: '10000',
  age:'19',
  dependents: '2'
  ),
  Person(
    id: 17,
    name: 'Aarav Saxena',
    imageURL: 'images/17.jpg',
    phoneNumber: '(+91) 888 999 7777',
    email: "aaravsaxena@gmail.com",
    idType: 0,
    cardNum: "789012345678",
    creditScore: -0.5,
    salary: '10000',
  age:'19',
  dependents: '2'
  ),
  Person(
    id: 18,
    name: 'Ananya Joshi',
    imageURL: 'images/18.jpg',
    phoneNumber: '(+91) 999 777 8888',
    email: "ananyajoshi@gmail.com",
    idType: 1,
    cardNum: "890123456789",
    creditScore: 5,
    salary: '10000',
  age:'19',
  dependents: '2'
  ),
  Person(
    id: 19,
    name: 'Aryan Gupta',
    imageURL: 'images/19.jpg',
    phoneNumber: '(+91) 777 888 9999',
    email: "aryangupta@gmail.com",
    idType: 0,
    cardNum: "901234567890",
    creditScore: -3,
    salary: '10000',
  age:'19',
  dependents: '2'
  ),
];

