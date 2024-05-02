/*
    DM50 - Javier Báscones Velázquez - 2024
*/

$fn=20;
PCB_WIDTH = 70;
PCB_HEIGHT = 149.9;

key1_rows = 5; //5 (1 for modeling)
key1_cols = 6; //6 (1 for modeling)
key2_rows = 4; //4 (1 for modeling)
key2_cols = 4; //4 (1 for modeling)

tolerance = 0.4; // tolerance margin (mm) 
keys_hspace = 4;
keys_vspace = 5;
r = 0.5; // chamfers

key_wall = 1;
key_height = 2+1;
key1_xspace = 11.5;
key1_yspace = 11;
key2_xspace = 14;
key2_yspace = 11;

junction_w = 0.8;
junction_h = 0.5;
junction_l = 2.0;
junction_r = 0.8;
junction_space = 1;
junction_hover = 1.0;

key_bottom_margin = 0.2;

push_wall = 0.6;
push_size = 4;
push_height = 0.0;
push_hole = 2;
push_r1   = 1;
push_r2   = 0.6;
push_r_h = 1;

border_width = 2;
border_height = 4;

holestop = 88.9;
holesbottom = 11.6;
holesmargin = 1.9;
holesradio = 1.0;
holesheight = 2.5;

wall01 = junction_h;

module insert_hole()
{
    translate([0, 0, -1])
    union()
    {
        translate([-push_size/2, -push_wall/2, 0]) cube([push_size, push_wall, push_hole+push_height+1]);
        translate([-push_wall/2, -push_size/2, 0]) cube([push_wall, push_size, push_hole+push_height+1]);
        translate([0, 0, 0]) cylinder(push_hole+1, push_r1, push_r1);
    }
}

module insert()
{
    translate([key1_l/2, key1_w/2, 0])
    union()
    {
        translate([0, 0, -push_r_h]) cylinder(push_r_h, push_r2, push_r1);
        translate([0, 0, 0]) cylinder(push_hole, push_r1, push_r1);
    }
}

module key( length=8, width=6, height=4 )
{   
    translate([-length/2, -width/2, -r])
    difference()
    {
        union()
        {
            translate([r, r, r])
            minkowski()
            {
              difference() {
              cube([length-r*2, width-r*2, height-r]);
                
              translate([-length/2, -width/2, height-2.5])
                rotate(a=[10,0,0])
                    cube([length*2, width*2, height-r]);
              }
              sphere(r=r);
            }

            translate([length/5 - junction_w / 2, -junction_l, r])
                cube([junction_w, junction_l+key_wall, junction_h]);

            translate([ length/5 * 4 - junction_w / 2, -junction_l, r])
                cube([junction_w, junction_l+key_wall, junction_h]);
            
            translate([length/2, width + junction_space, r])
            union()
            {
                cylinder(junction_h, junction_r, junction_r);
                translate([-junction_r, -junction_space - junction_r/2 - key_wall/2 - tolerance/2, 0])
                    cube([junction_r * 2, key_wall+junction_space , junction_h]);
            }
        }
        
        translate([-length/2, -width/2, -r]) cube([length*2, width*2, r*2]);
        translate([length/2, width/2, -r]) insert_hole();
    }
}

module diff( length=8, width=6, height=4 )
{
    translate([-length/2, -width/2, -r])    
    union()
    {
        translate([r-tolerance, r-tolerance - key_bottom_margin, -1])
        minkowski()
        {
          cube([length+tolerance*2-r*2, width+tolerance*2-r*2+key_bottom_margin, height*2]);
          sphere(r=r);
        }
        
        translate([length/2, width + junction_space, -0.5])
        union()
        {
            cylinder(height*2, junction_r+tolerance, junction_r+tolerance);
            translate([-junction_r-tolerance, -junction_space - junction_r/2, junction_h-0.5])
                cube([junction_r*2+tolerance*2, junction_space + junction_r/2, height*2]);
        }
        
        translate([length/5, 0, -0.5])
        union()
        {
            translate([-junction_w / 2 - tolerance, -junction_l, junction_h-0.5])
                cube([junction_w+tolerance*2, junction_l+key_wall, height*2]);
        }

        translate([length/5*4, 0, -0.5])
        union()
        {
            translate([ - junction_w / 2 - tolerance, -junction_l, junction_h-0.5])
                cube([junction_w+tolerance*2, junction_l+key_wall, height*2]);
        }
        
    }
}


module keypad( base = false)
{
    difference()
    {
        union()
        {
            difference()
            { 
                if (base == true)
                    cube([PCB_WIDTH, PCB_HEIGHT, 2]); // BASE
                else 
                    cube([PCB_WIDTH, 99.5, wall01]); // KEYPAD
                
                // KEYS TOP
                translate([6.2,50,0])
                for ( y = [0 : key1_rows-1] ){
                    for ( x = [0 : key1_cols-1] ){
                        translate([key1_xspace*x, key1_yspace*y, 0]) diff(length = 8, width = 6, height = 3); // HOLE
                        if (base == true) translate([key1_xspace*x, key1_yspace*y, -1]) cylinder(5, 4.5, 4.5); // DOME
                    }
                }
                
                // KEYS BOTTOM
                translate([20.8,6,0])
                for ( y = [0 : key2_rows-1] ){
                    for ( x = [0 : key2_cols-1] ){
                        translate([key2_xspace*x, key2_yspace*y, 0]) diff(length = 10, width = 6, height = 3); // HOLE
                        if (base == true) translate([key2_xspace*x, key2_yspace*y, -1]) cylinder(5, 4.5, 4.5); // DOME
                    }
                }
                
                // KEYS LEFT
                translate([6.2,6,0])
                for ( y = [0 : key2_rows-1] ){
                    translate([0, key2_yspace*y, 0]) diff(length = 8, width = 6, height = 3); // HOLE
                    if (base == true) translate([0, key2_yspace*y, -1]) cylinder(5, 4.5, 4.5); // DOME
                }

                //SCREEN
                translate([1, 100, -5]) cube([68, 49, 20]);
                //SCREEN
                //translate([4.8, 105, -5]) cube([61, 33, 20]);
                
                if (base != true)
                    translate([58, 97, -2]) cylinder(5, 0.7, 0.7); // LED
                else
                    translate([58, 97, -2]) cylinder(5, 2, 2); // LED
            }


            if (base != true)
            {
                // KEYS TOP
                translate([6.2,50,0])
                for ( y = [0 : key1_rows-1] ){
                    for ( x = [0 : key1_cols-1] ){
                        translate([key1_xspace*x, key1_yspace*y, wall01-junction_h]) 
                            key( length = 8, width = 6, height = 3);
                    }
                }
                
                // KEYS BOTTOM
                translate([20.8,6,0])
                for ( y = [0 : key2_rows-1] ){
                    for ( x = [0 : key2_cols-1] ){
                        translate([key2_xspace*x, key2_yspace*y, 0]) key(length = 10, width = 6, height = 3); // HOLE
                    }
                }

                // KEYS LEFT
                translate([6.2,6,0])
                for ( y = [0 : key2_rows-1] ){
                    translate([0, key2_yspace*y, 0]) key(length = 8, width = 6, height = 3); // HOLE
                }
            }
            else
            {
                
                difference() // SCREEN
                {   
                    translate([0, 100, 0]) cube([PCB_WIDTH, 50, border_height]);
                    translate([1, 100+1, -2]) cube([PCB_WIDTH-2, 50-2, border_height]);

                    //translate([4.8, 105, -5]) cube([61, 33, 20]);

                    translate([5.8, 105+1, -5]) 
                    minkowski()
                    {
                      cube([61-2, 33-2, 20]);
                      cylinder(2,1,1);
                    }

                    translate([2, 104, border_height-1]) 
                    minkowski()
                    {
                      cube([PCB_WIDTH-4, 40, 2]);
                      cylinder(2,2,2);
                    }
                }
                // FRAME
                    translate([-border_width,-border_width,0]) cube([PCB_WIDTH+border_width*2, border_width, border_height-1]);
                    translate([-border_width,PCB_HEIGHT,0]) cube([PCB_WIDTH+border_width*2, border_width, border_height]);
                    translate([PCB_WIDTH,-border_width,0]) cube([border_width, PCB_HEIGHT+border_width*2, border_height]);
                    translate([-border_width,-border_width,0]) cube([border_width, PCB_HEIGHT+border_width*2, border_height]);
            }
        }

        // rounded corners
        rotate([0, 0, 180]) 
        difference()
        {
            translate([0, 0, -1]) cube([6, 6, 10]);
            translate([0, 0, -2]) cylinder(14, 2, 2);
        }

        translate([PCB_WIDTH, PCB_HEIGHT, 0]) 
        difference()
        {
            translate([0, 0, -1]) cube([6, 6, 10]);
            translate([0, 0, -2]) cylinder(14, 2, 2);
        }

        translate([0, PCB_HEIGHT, 0])
        rotate([0, 0, 90]) 
        difference()
        {
            translate([0, 0, -1]) cube([6, 6, 10]);
            translate([0, 0, -2]) cylinder(14, 2, 2);
        }
        
        translate([PCB_WIDTH, 0, 0])
        rotate([0, 0, 270]) 
        difference()
        {
            translate([0, 0, -1]) cube([6, 6, 10]);
            translate([0, 0, -2]) cylinder(14, 2, 2);
        }        
        
        // HOLES
        if (base == true)
        {        
            translate([holesmargin, holestop, -1]) cylinder(1+holesheight, holesradio, holesradio);
            translate([PCB_WIDTH-holesmargin, holestop, -1]) cylinder(1+holesheight, holesradio, holesradio);

            translate([holesmargin, holesbottom, -1]) cylinder(1+holesheight, holesradio, holesradio);
            translate([PCB_WIDTH-holesmargin, holesbottom, -1]) cylinder(1+holesheight, holesradio, holesradio);
        }        
    }
}

module lcd()
{
}

module faceplate()
{
    difference()
    {
        // KEYS TOP
        cube([PCB_WIDTH, 99.5, 0.1]);
        translate([6.2,50,0])
        for ( y = [0 : key1_rows-1] ){
            for ( x = [0 : key1_cols-1] ){
                translate([key1_xspace*x, key1_yspace*y, 0]) cube([8 + tolerance, 6 + tolerance, 10], center = true);
            }
        }
        
        // KEYS BOTTOM
        translate([20.8,6,0])
        for ( y = [0 : key2_rows-1] ){
            for ( x = [0 : key2_cols-1] ){
                translate([key2_xspace*x, key2_yspace*y, 0]) cube([10 + tolerance, 6 + tolerance, 10], center = true);
            }
        }
        
        // KEYS LEFT
        translate([6.2,6,0])
        for ( y = [0 : key2_rows-1] ){
            translate([0, key2_yspace*y, 0]) cube([8 + tolerance, 6 + tolerance, 10], center = true);
        }
    }
}


// DRAW KEYBOARD
// KEY1 = 8x6, KEY2 = 8.5x6

space = 0;

//color([0.9,0.9,0.9, 0.08])
//translate([0, 0, 3+space*2])
//faceplate(); // faceplate

color([0.4,0.4,0.4])
//translate([0, 0, 0.5+2+space]) 
keypad( base = false); // keypad

//color([0.4,0.4,0.4])
//keypad( base = true); // base

//color([0.37,0.40,0.18])
//translate([2, 105, 0]) cube([67, 33, 2]); // LCD
