//Last change 18 december 2013
include <write.scad>

supportWidth = 60;
supportHeight = 50;
supportThickness = 2;
coverThickness = 2;
penDia = 8.3;
penAttach=20;

$fn=100;


/* *************************************************
 * Mes fonctions à moi
 * *********************************************** */
module grip1() {
	translate([2*supportWidth/3,supportHeight/4,((2*supportThickness)+coverThickness)])
	rotate (90,[1,0,0])
	difference() {
		cylinder(r=3,h=2);
		translate([-7,-0.2,-2]) cube([15,15,5]);
	}
}

module grip2() {
	translate([supportWidth/3,supportHeight/4,((2*supportThickness)+coverThickness)])
	rotate (90,[1,0,0])
	difference() {
		cylinder(r=3,h=2);
		translate([-7,-0.2,-2]) cube([15,15,5]);
	}
}

module grip3() {
	translate([2*supportWidth/3,supportHeight+20,((2*supportThickness)+coverThickness)]) 
	rotate (180,[1,0,00]) 
	rotate(90,[0,0,1]) 
		grip1();
}

module rectangleArrondi(x, y, z) {
  translate([2.5,2.5,0])
  hull() {
    cube([x-5,y-05,z]);

    translate([2.5,2.5,0])
    cylinder(r=5,h=z);

    translate([x-7.5,2.5,0])
    cylinder(r=5,h=z);

    translate([x-7.5,y-7.5,0])
    cylinder(r=5,h=z);

    translate([2.5,y-7.5,0])
    cylinder(r=5,h=z);
  }
}


module front() {
   difference()
   {
     rectangleArrondi(supportWidth,supportHeight,supportThickness);
     rotate(45, [0, 0, 1]) translate([-20,10,0]) 
     cube([150,supportHeight,supportThickness*4]);
   }
}

module back(){
   translate([0,0,supportThickness+coverThickness])
   difference()
   {
     rectangleArrondi(supportWidth,supportHeight,supportThickness);
     rotate(45, [0, 0, 1]) translate([-20,10,0]) 
     cube([150,supportHeight,supportThickness*4]);
   };

}

module attach_1() {
   translate([7,0,supportThickness/2])
   cube([supportWidth-20,supportThickness,supportThickness+coverThickness]);
}

module attach_2() {
   translate([supportWidth-supportThickness,13,supportThickness/2])
   cube([supportThickness,supportHeight-20,supportThickness+coverThickness]);
}

module pen_support_1() {
	translate([10,-(penDia),(supportThickness*3)+coverThickness])
	rotate(90,[0,90,0])
	difference() {
		cylinder(h = penAttach, r=penDia+supportThickness);
		cylinder(h = penAttach, r=penDia);
	}
}

module text() {
	translate([40,48,supportThickness+supportThickness+coverThickness-1.5])
	rotate(45,[0,0,1])
	rotate(180,[0,0,1])
	write("Nekloth",h=10,t=2,font="BlackRose.dxf",space=0.8);
}

/* ****** LA TOTALE ************************* */
rotate(180,[0,0,1])
{
	front();
	back();
	attach_1();
	attach_2();
	pen_support_1();
	grip1();
	grip2();
	grip3();
	text();
}