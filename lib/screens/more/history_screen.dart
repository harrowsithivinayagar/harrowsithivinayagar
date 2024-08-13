import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('History',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Our Temple History',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'As stated in the Puranas, the image created by Goddess Parvathi of Lord Ganesha differs from the image he resides in today. Goddess Parvathi created Lord Ganesha using clay from the earth to be the guard of her palace. Tasked with the duty of not letting anyone into her palace, Lord Ganesha went as far as depriving Lord Shiva access to the palace. Infuriated by such an act, Lord Shiva beheaded the young lord unknowning of his origins. Adhering to the word of Goddess Parvathi, Lord Shiva set about looking for the first creation he would come across to create another head in its image for Lord Ganesha. This is the story of how Lord Ganesha was reborn with the head of an elephant.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Lord Ganesha initially had fundamental godly powers; however, with the rebirth of an elephant head he had immense strength, the power to remove obstacles with his trunk. For the goodness of the world, Lord Ganesha broke off his own tusk. Such a sight can be seen on the God in his auspicious form.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'At the very beginning, the joint efforts of five devotees, Mr. P. Thanabalasingam, Mr. M. Mohanadas, Mr. K. Gengatharan, Mr. V. Sriranjan and Mr. S. Arunan blessed by Lord Ganesha in 2001. The first pooja was held in North Harrow at the St. Johns Ambulance Hall using the pictures of Lord Ganesha, Lord Murugan and Goddess Amman. Every Tuesday and Friday evenings poojas were held for the three gods.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'After several months, special statues of Lord Ganesha and Goddess Amman were sent from India and special poojas (Kumbabishekhams) took place as a special coronation for the Gods taking their place in our temple. However, due to complications, the Gods had to be moved into the Shakthi Centre in Harrow Weald and poojas took place every Tuesday and Friday.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Over time, as the temple grew in stature, a desire to find Lord Ganesha a permanent home grew in the hearts of the devotees. As a result, the temple management and Board of Trustees, with the help of devotees, set out to attain such a place. Through the hard work of the trustees and the wholehearted donations of the devotees an opportunity to obtain a loan with the bank arose. The result of such tireless work is the current home of our Lord Ganesha.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'To get to the current state of the temple, many changes had to take place. A lot of construction was required; however, Lord Ganesha did not allow for this nor did the temple have the money. As such, our volunteers came forward offering all kinds of services to help build the temple and construction began.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'In the blistering cold November of 2004, construction work continued in full force. Volunteers, in their bare feet, stood for Lord Ganesha ensuring the completion of the project. The combined efforts of the Board of Trustees, Committee and devotees saw the completion of the construction.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '“Thai Pongal”, an auspicious Hindu/Tamil day in January celebrating the new harvest thanking the Gods for a bountiful yield, saw the completion of the project in 2005. Such a joyous occasion saw more reason to celebrate with the official coronation of our Lord Ganesha. What was bought as a warehouse with no electricity or gas facilities and just a place with storage rooms now stands as the holy temple for the God of wisdom.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Now, Monday to Friday, there are evening poojas and Saturday and Sunday midday poojas take place. Since 2008, Pillaiyar story festivals take place for Lord Ganesha every year. For eight years since opening the temple, the only thing missing was a central shrine for Lord Ganesha (moolasthanam). Lord Ganesha along with multiple other Gods and Goddesses were blessed with their individual shrines. A five-foot-tall effigy of Lord Ganesha took its place in his centre shrine. Along with this came Lord Shiva, Goddess Parvathi, Lord Murugan, Goddess Vallee and Devanai. All shrines were chiseled in Avinashi, India.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'From the holy River Ganges, a stone was taken and chiselled into the form of Lord Shiva who resides in our temple today. This holy statue is prayed to and dressed auspiciously on special occasions related to Lord Shiva. With all the Navagraha gods aligned, on the special day in the Hindu calendar (21-10-2010), the Maha Kumbabhishekam took place for all the Gods in the temple. The next 48 days saw the temple host mandalabhishekams in line with Hindu traditions.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'In all the temples in London, Harrow Sithi Vinayagar hosts certain activities that make us special. Garland tying for all the gods within our temple, temple cooking, making of the ghee lamps and many other activities like this are all done by our temple volunteers.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Since 22.10.2010, four poojas have taken place daily: 9.00am, midday, 5.00pm and 8.00pm. From 9am to 2pm, the temple doors open and are closed till 5pm. Following this, the temple is open again from 5.00pm till 9.30pm. On special occasions such as New Year’s Eve and Tamil New Year’s, the temple is open from 7am till 9pm continuously.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'The temple is a part of the British Saiva Organisation. As such we follow certain activities in line with the organisation. Like many other temples in London, our temple holds many charitable activities for our people back in our homeland who are less fortunate than ourselves. As such, since 2013, we have aided and funded the education of orphans including 24 boys and 6 girls who have all enrolled at Jaffna/Stanley and are boarded in their housing. We have not just focused on their education but have also given attention to the growth of their fine arts and sports which we deem equally necessary to a child’s life.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Moreover, girls who have been impacted by the Civil War and been prisoners of the war are currently being looked after by the British Saiva Organisation. We have offered aid in many shapes and forms including legal help for those listed above.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'In addition to this, in Jaffna/Dharmapuram, 41 elderly individuals were in need of accommodation in the Namasivaya illam. The temple sent £10,000 and as a result, till this day, they all live in peace in a place they can call home.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'As a result of the Coronavirus pandemic affecting the whole world, the temple made it necessary to start a side project to help the people suffering in the Northern and Eastern provinces of Sri Lanka without the basic essentials and foods. As a result, we were able to raise £2000 through the joint efforts of the trustees and devotees and sent it to Sri Lanka. The essential foods were supplied to suffering people in Savukkadi village, Koduvamadu village in Batticaloa and Kilinochchi district on the 9th of April 2020.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Our next project, at the cost of £5000, is to build a few wells for the people who struggle without water back home. Those who wish to contribute to this project can contact the temple directly to arrange your donations.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '‘Anbe Sivam’ is a mantra we tirelessly work towards through our charitable aid. We pray to Lord Ganesha with his blessings and guidance to help us continue our endeavours.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Board of Trustees\nSri Sithi Vinayagar Thevasthanam (Harrow)',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
