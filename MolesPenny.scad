//Last change 18 december 2013
include <write.scad>

supportWidth = 45;
supportHeight = 30;
supportThickness = 2;
coverThickness = 3;
penDia = 8.2/2;
penAttach=15;

$fn=100;


/* *************************************************
 * Mes fonctions à moi
 * *********************************************** */
module grip1() {
	translate([2*supportWidth/3,supportHeight/4,((2*supportThickness)+coverThickness)])
	translate([0,10,0])
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
	translate([-11,supportHeight-2,((2*supportThickness)+coverThickness)]) 
	rotate (180,[1,0,00]) 
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
     rotate(30, [0, 0, 1]) translate([-20,8,0]) 
     cube([150,supportHeight,supportThickness*4]);
   }
}

module back(){
   translate([0,0,supportThickness+coverThickness])
   difference()
   {
     rectangleArrondi(supportWidth,supportHeight,supportThickness);
     //rotate(45, [0, 0, 1]) translate([-20,5,0]) 
     rotate(30, [0, 0, 1]) translate([-20,8,0])
     cube([150,supportHeight,supportThickness*4]);
   };

}

module attach_1() {
   translate([7,0,supportThickness/2])
   cube([supportWidth-15,supportThickness,supportThickness+coverThickness]);
}

module attach_2() {
   translate([supportWidth-supportThickness,5,supportThickness/2])
   cube([supportThickness,supportHeight-10,supportThickness+coverThickness]);
}

module pen_support_1() {
	translate([6,-(penDia),(penDia/2)+coverThickness])
	rotate(90,[0,90,0])

	difference() {
		difference() {
			cylinder(h = penAttach, r=penDia+supportThickness);
			cylinder(h = penAttach, r=penDia);
		}

		translate([-7,-36,-5])
		rotate(45,[0,0,1])
		cube ([penAttach*2,20,30]);
	}
}

module text() {
	rotate(180,[0,1,0])
	rotate(90,[0,0,1])
	translate([8,5,-1])
	rotate(-90,[0,0,1])
	rotate(180,[0,0,1])
	write("Arnaud",h=5,t=2,font="Orbitron.dxf",space=1.2);
}

module insertionWay() {
	translate([33,12,5.5])
	write(">",h=5,t=2,font="orbitron.dxf");
}


/* ****** LA TOTALE ************************* */
translate([0,0,supportWidth])
rotate(-90,[0,1,0])
rotate(180,[0,0,1])
{
	front();
	text();
	back();
	attach_1();
	attach_2();
	pen_support_1();
	grip1();
	grip2();
	grip3();
	insertionWay();

}