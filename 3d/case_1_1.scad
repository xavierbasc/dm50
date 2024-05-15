/*
    DM50 - Javier Báscones Velázquez - 2024
*/

$fn=30;
PCB_WIDTH = 70;
PCB_HEIGHT = 149.9;

WALL = 1.5;
WALL_PUSH = 3.8;

LCD_W = 67.8;
LCD_H = 47.96;
LCD_VIEW_YPOS = 26.3;
LCD_VIEW_W = 61;
LCD_VIEW_H = 35;

COLOR_CASE = [0.20, 0.20, 0.20];
COLOR_FRAME = [0.10, 0.10, 0.10];

key1_rows = 5; //5 (1 for modeling)
key1_cols = 6; //6 (1 for modeling)
key2_rows = 4; //4 (1 for modeling)
key2_cols = 4; //4 (1 for modeling)

tolerance = 0.4; // tolerance margin (mm) 
tolerance2 = 0.3; // tolerance margin (mm) 
keys_hspace = 4;
keys_vspace = 5;
r = 0.5; // chamfers

key_wall = 1;
key_height = 2+1;
key1_xspace = 11.0;
key1_yspace = 10;
key2_xspace = 13;
key2_yspace = 10;

junction_w = 0.8;
junction_h = 0.5;
junction_l = 1.8;
junction_r = 0.6;
junction_space = 0.3; // 0.2
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
border_height = 5.5;

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
            
            translate([junction_r, width + junction_space, r])
            union()
            {
                cylinder(junction_h, junction_r, junction_r);
                translate([-junction_r, -junction_space - junction_r/2 - key_wall/2 - tolerance/2, 0])
                    cube([junction_r * 2, key_wall+junction_space , junction_h]);
            }
            
            translate([length-junction_r, width + junction_space, r])
            union()
            {
                cylinder(junction_h, junction_r, junction_r);
                translate([-junction_r, -junction_space - junction_r/2 - key_wall/2 - tolerance/2, 0])
                    cube([junction_r * 2, key_wall+junction_space , junction_h]);
            }
            
            
            /*
            translate([length/2, width + junction_space, r])
            union()
            {
                cylinder(junction_h, junction_r, junction_r);
                translate([-junction_r, -junction_space - junction_r/2 - key_wall/2 - tolerance/2, 0])
                    cube([junction_r * 2, key_wall+junction_space , junction_h]);
            }
            */
        }
        
        translate([-length/2, -width/2, -r]) cube([length*2, width*2, r*2]);
        //translate([length/2, width/2, -r]) insert_hole();
    }
}

module diff( length=8, width=6, height=4 )
{
    translate([-length/2, -width/2, -r])    
    union()
    {
        translate([r-tolerance2, r-tolerance2 - key_bottom_margin/2 - 1, -1])
        minkowski()
        {
          cube([length+tolerance2*2-r*2, width+tolerance2*2-r*2+key_bottom_margin/2+2, height*2]);
          sphere(r=r);
        }
        
        /*
        translate([length/2, width + junction_space, -0.5])
        union()
        {
            cylinder(height*2, junction_r+tolerance2, junction_r+tolerance2);
            translate([-junction_r-tolerance2, -junction_space - junction_r/2, junction_h-0.5])
                cube([junction_r*2+tolerance2*2, junction_space + junction_r/2, height*2]);
        }
        
        translate([length/5, 0, -0.5])
        union()
        {
            translate([-junction_w / 2 - tolerance, -junction_l, junction_h-0.5])
                cube([junction_w*7+tolerance*2, junction_l+key_wall, height*2]);
        }
        */
        
        /*
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
        */
        
    }
}

module frame()
{
    difference()
    {
        translate([2, 104, 3]) 
        minkowski()
        {
          translate([tolerance/2, tolerance/2, 0]) 
          cube([PCB_WIDTH-4-tolerance, 40-tolerance, 0.5]);
          cylinder(0.5,2,2);
        }

        translate([5.8, 105+1, -5]) 
        minkowski()
        {
          cube([61-2, 33-2, 20]);
          cylinder(2,1,1);
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
                    cube([PCB_WIDTH, PCB_HEIGHT, WALL_PUSH]); // BASE
                else
                    translate([WALL+tolerance,1.5+tolerance,0])
                    cube([PCB_WIDTH-WALL*2-tolerance*2, 97.5-tolerance, wall01]); // KEYPAD
                
                // KEYS TOP
                translate([7.2,50,0])
                for ( y = [0 : key1_rows-1] ){
                    for ( x = [0 : key1_cols-1] ){
                        translate([key1_xspace*x, key1_yspace*y, 0]) diff(length = 8, width = 6, height = 3); // HOLE
                        //if (base == true) translate([key1_xspace*x, key1_yspace*y, -1]) cylinder(5, 4.5, 4.5); // DOME
                    }
                }
                
                // KEYS BOTTOM
                translate([22.2,7,0])
                for ( y = [0 : key2_rows-1] ){
                    for ( x = [0 : key2_cols-1] ){
                        translate([key2_xspace*x, key2_yspace*y, 0]) diff(length = 10, width = 6, height = 3); // HOLE
                        //if (base == true) translate([key2_xspace*x, key2_yspace*y, -1]) cylinder(5, 4.5, 4.5); // DOME
                    }
                }
                
                // KEYS LEFT
                translate([7.2,7,0])
                for ( y = [0 : key2_rows-1] ){
                    translate([0, key2_yspace*y, 0]) diff(length = 8, width = 6, height = 3); // HOLE
                    //if (base == true) translate([0, key2_yspace*y, -1]) cylinder(5, 4.3, 4.3); // DOME
                }

                //SCREEN
                translate([1, 100-tolerance, -5]) cube([68, LCD_H+tolerance*2, 20]);
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
                translate([7.2,50,0])
                for ( y = [0 : key1_rows-1] ){
                    for ( x = [0 : key1_cols-1] ){
                        translate([key1_xspace*x, key1_yspace*y, wall01-junction_h]) 
                            key( length = 8, width = 6, height = 3);
                    }
                }
                
                // KEYS BOTTOM
                translate([22.2,7,0])
                for ( y = [0 : key2_rows-1] ){
                    for ( x = [0 : key2_cols-1] ){
                        translate([key2_xspace*x, key2_yspace*y, 0]) key(length = 10, width = 6, height = 3); // HOLE
                    }
                }

                // KEYS LEFT
                translate([7.2,7,0])
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
                    translate([0,0,0]) cube([PCB_WIDTH, WALL, border_height]);
                    translate([0,PCB_HEIGHT-WALL,0]) cube([PCB_WIDTH, WALL, border_height]);
                    translate([PCB_WIDTH-WALL,0,0]) cube([WALL, PCB_HEIGHT, border_height]);
                    translate([0,0,0]) cube([WALL, PCB_HEIGHT, border_height]);
            }
        }

        // rounded corners
                
        translate([2, 2, 0]) 
        rotate([0, 0, 180]) 
        difference()
        {
            translate([0, 0, -1]) cube([6, 6, 10]);
            translate([0, 0, -2]) cylinder(14, 2, 2);
        }

        translate([PCB_WIDTH-2, PCB_HEIGHT-2, 0]) 
        difference()
        {
            translate([0, 0, -1]) cube([6, 6, 10]);
            translate([0, 0, -2]) cylinder(14, 2, 2);
        }

        translate([2, PCB_HEIGHT-2, 0])
        rotate([0, 0, 90]) 
        difference()
        {
            translate([0, 0, -1]) cube([6, 6, 10]);
            translate([0, 0, -2]) cylinder(14, 2, 2);
        }
        
        translate([PCB_WIDTH-2, 2, 0])
        rotate([0, 0, 270]) 
        difference()
        {
            translate([0, 0, -1]) cube([6, 6, 10]);
            translate([0, 0, -2]) cylinder(14, 2, 2);
        }        
        
        // HOLES
        if (base == true)
        {        
            //translate([holesmargin, holestop, -1]) cylinder(1+holesheight, holesradio, holesradio);
            //translate([PCB_WIDTH-holesmargin, holestop, -1]) cylinder(1+holesheight, holesradio, holesradio);

            //translate([holesmargin, holesbottom, -1]) cylinder(1+holesheight, holesradio, holesradio);
            //translate([PCB_WIDTH-holesmargin, holesbottom, -1]) cylinder(1+holesheight, holesradio, holesradio);

            translate([12.7, 12, 2.5/2-0.1]) cylinder(2.5, 1.6, 1.6, center=true);
            translate([54.7, 12, 2.5/2-0.1]) cylinder(2.5, 1.6, 1.6, center=true);
            
        }        
        
    }
}

/*
translate([1, 101, 0]) 
{
    translate([4,(LCD_H-LCD_VIEW_H)-(LCD_VIEW_YPOS-LCD_VIEW_H/2),5]) //LCD_VIEW_YPOS
            cube([LCD_VIEW_W, LCD_VIEW_H, 8]); // LCD

}
*/

module lcd()
{
}

module faceplate()
{
    difference()
    {
        // KEYS TOP
        cube([PCB_WIDTH-WALL*2, 98, 0.1]);
        translate([5.7,48.5,0])
        for ( y = [0 : key1_rows-1] ){
            for ( x = [0 : key1_cols-1] ){
                translate([key1_xspace*x, key1_yspace*y, 0]) cube([8 + tolerance, 6 + tolerance, 10], center = true);
            }
        }
        
        // KEYS BOTTOM
        translate([20.7,5.5,0])
        for ( y = [0 : key2_rows-1] ){
            for ( x = [0 : key2_cols-1] ){
                translate([key2_xspace*x, key2_yspace*y, 0]) cube([10 + tolerance, 6 + tolerance, 10], center = true);
            }
        }
        
        // KEYS LEFT
        translate([5.7,5.5,0])
        for ( y = [0 : key2_rows-1] ){
            translate([0, key2_yspace*y, 0]) cube([8 + tolerance, 6 + tolerance, 10], center = true);
        }
    }
}


// DRAW KEYBOARD
// KEY1 = 8x6, KEY2 = 8.5x6

space = 0;

//color([0.9,0.9,0.9])
//translate([WALL, WALL, WALL_PUSH+0.6+space*3])
//faceplate(); // faceplate

//color(COLOR_CASE)
//translate([0, 0, WALL_PUSH+space]) 
//keypad( base = false); // keypad

color([0.6,0.6,0.6])
keypad( base = true); // base

/*
translate([0, 0, space]) 
color(COLOR_FRAME)
frame();
*/

//cube([70, 10, 20]);

// DOMES

/*
translate([7.2, 7, 0.5/2])
for ( y = [0 : key2_rows-1] ){
    translate([0, key2_yspace*y, 0]) cylinder(0.5, 3.5, 3.5, center=true);
    for ( x = [0 : key2_cols-1] ){
        translate([15+key2_xspace*x, key2_yspace*y, 0]) cylinder(0.5, 3.5, 3.5, center=true);
    }
}

translate([7.2, 50, 0.5/2])
for ( y = [0 : key1_rows-1] ){
    for ( x = [0 : key1_cols-1] ){
        translate([key1_xspace*x, key1_yspace*y, 0]) cylinder(0.5, 3.5, 3.5, center=true);
    }
}

color([0.6,0.6,0.6]) translate([7.2, 7, 0]) cylinder(5, 3, 3, center=true);
color([0.6,0.6,0.6]) translate([22.2, 7, 0]) cylinder(5, 3, 3, center=true);
color([0.6,0.6,0.6]) translate([35.2, 7, 0]) cylinder(5, 3, 3, center=true);
color([0.6,0.6,0.6]) translate([48.2, 7, 0]) cylinder(5, 3, 3, center=true);
color([0.6,0.6,0.6]) translate([61.2, 7, 0]) cylinder(5, 3, 3, center=true);

color([0.6,0.6,0.6]) translate([7.2, 17, 0]) cylinder(5, 3, 3, center=true);
color([0.6,0.6,0.6]) translate([7.2, 27, 0]) cylinder(5, 3, 3, center=true);
color([0.6,0.6,0.6]) translate([7.2, 37, 0]) cylinder(5, 3, 3, center=true);

color([0.6,0.6,0.6]) translate([7.2, 50, 0]) cylinder(5, 3, 3, center=true);
color([0.6,0.6,0.6]) translate([18.2, 50, 0]) cylinder(5, 3, 3, center=true);
color([0.6,0.6,0.6]) translate([29.2, 50, 0]) cylinder(5, 3, 3, center=true);
color([0.6,0.6,0.6]) translate([40.2, 50, 0]) cylinder(5, 3, 3, center=true);
color([0.6,0.6,0.6]) translate([51.2, 50, 0]) cylinder(5, 3, 3, center=true);
color([0.6,0.6,0.6]) translate([62.2, 50, 0]) cylinder(5, 3, 3, center=true);
color([0.6,0.6,0.6]) translate([7.2, 60, 0]) cylinder(5, 3, 3, center=true);
color([0.6,0.6,0.6]) translate([7.2, 70, 0]) cylinder(5, 3, 3, center=true);
color([0.6,0.6,0.6]) translate([7.2, 80, 0]) cylinder(5, 3, 3, center=true);
color([0.6,0.6,0.6]) translate([7.2, 90, 0]) cylinder(5, 3, 3, center=true);
*/

/*
color([0.37,0.40,0.18])
translate([1, 101, 0]) 
{
    translate([0, 0, -5]) cube([LCD_W, LCD_H, 2]); // LCD
}
*/

/*
color([181/256,166/256,66/256]) // LATON
translate([7.2, 7, 2.5/2]) 
difference()
{
    cylinder(2.5, 1.6, 1.6, center=true);
    cylinder(5, 1.0, 1.0, center=true);
}
*/

