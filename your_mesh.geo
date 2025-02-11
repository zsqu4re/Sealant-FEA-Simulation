// ✅ Enable OpenCASCADE kernel (recommended for complex geometry)
SetFactory("OpenCASCADE");

// ✅ Define mesh size
lc = 0.01;

// ✅ Define U-channel (Aluminum)
bottom = newreg;
Rectangle(bottom) = {-0.05, -0.05, 0, 0.1, 0.01};  // Bottom part
left_wall = newreg;
Rectangle(left_wall) = {-0.05, -0.05, 0, 0.01, 0.1};  // Left wall
right_wall = newreg;
Rectangle(right_wall) = {0.04, -0.05, 0, 0.01, 0.1};  // Right wall

// ✅ Define Silicon block
silicon_block = newreg;
Rectangle(silicon_block) = {-0.02, -0.04, 0, 0.04, 0.08};  // Inside Silicon block

// ✅ Set mesh size for all parts
MeshSize {bottom, left_wall, right_wall, silicon_block} = lc;

// ✅ Merge overlapping geometries
s() = BooleanFragments{ Surface{bottom, left_wall, right_wall, silicon_block}; Delete; }{};

// ✅ Assign physical surfaces for FEA
Physical Surface(1) = {s[0], s[1], s[2]};  // Aluminum
Physical Surface(2) = {s[#s-1]};  // Silicon (last created surface)

// ✅ Generate 2D mesh
Mesh 2;

