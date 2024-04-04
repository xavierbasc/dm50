/*
    DM50 - Javier Báscones Velázquez - 2024
*/

$fn=30;
// AAA batery
aaa_h = 44.5;
aaa_d = 10.5;

// PCB -----------------------
pcb_height = 138;
pcb_thickness = 2;
pcb_width = 71;
// CASE -----------------------
// thickness
r = 2; // case chamfers
t = 2;
// width
w = 77; 
// height
h = 144;
// depth
d = 12;
// height bottom
bottom_height = t+11; // d aaa = 10.5mm
bottom_sup_height = 3;
bottom_sup_ymin = t;
bottom_sup_ymax = 85;
bottom_sup_xmin = t;
bottom_sup_xmax = w-t;

bottom_ysupports = 5;
bottom_xsupports = 5;

screw_h = 95;
screw_r = 6;

// pcb supports
pcb_hight = 5;
sup_hight = 4;
keypad_radio_sup = 1;

// AAA
color( "gray", 1.0 )
translate([18,120,aaa_d/2+t])
rotate([0,90,0])
union(){
cylinder(d=aaa_d,h=aaa_h);
translate([0,aaa_d,0])
cylinder(d=aaa_d,h=aaa_h);
}

//cube(size = [w, t, bottom_height]);

difference()
{
    translate([r, r, 0])
    minkowski()
    {
      cube([w-r*2,h-r*2,bottom_height]);
      cylinder(r=2,h=1);
    }
    
    translate([r*2, r*2, t])
    minkowski()
    {
      cube([w-r*4,h-r*4,bottom_height+10]);
      cylinder(r=2,h=1);
    }    
}

// support
for ( i = [0 : bottom_ysupports-1] ){
    translate([0, bottom_sup_ymin+i*(bottom_sup_ymax-bottom_sup_ymin-t)/(bottom_ysupports-1), t])
    cube(size = [w, t, bottom_sup_height]);
}

for ( i = [0 : bottom_xsupports-1] ){
    translate([bottom_sup_xmin+i*(bottom_sup_xmax-bottom_sup_xmin-t)/(bottom_xsupports-1), 0, t])
    cube(size = [t, bottom_sup_ymax, bottom_sup_height]);
}

// screws
translate([6, screw_h, 0])
cylinder(h=bottom_sup_height+t, r=screw_r, center=false);
translate([w-6, screw_h, 0])
cylinder(h=bottom_sup_height+t, r=screw_r, center=false);

//color( "DarkGreen", 1.0 )
//translate([0,0,pcb_hight+t])
//cube(size = [pcb_width,pcb_height,pcb_thickness]);

//cylinder(h=20, r=keypad_radio_sup, center=true);
