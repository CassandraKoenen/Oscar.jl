const AnyVecOrMat = Union{MatElem, AbstractVecOrMat}


export AffineHalfspace,
    AffineHyperplane,
    Cone,
    PointVector,
    PolyhedralComplex,
    PolyhedralFan,
    Polyhedron,
    Halfspace,
    Hyperplane,
    SubdivisionOfPoints,
    IncidenceMatrix,
    LinearHalfspace,
    LinearHyperplane,
    LinearProgram,
    RayVector,
    SubObjectIterator,
    affine_equation_matrix,
    affine_hull,
    affine_inequality_matrix,
    all_triangulations,
    archimedean_solid,
    ambient_dim,
    bipyramid,
    birkhoff,
    boundary_lattice_points,
    catalan_solid,
    codim,
    combinatorial_symmetries,
    common_refinement,
    cone_from_inequalities,
    cones,
    convex_hull,
    cross,
    cube,
    delpezzo,
    dim,
    ehrhart_polynomial,
    fano_simplex,
    faces,
    facets,
    face_fan,
    feasible_region,
    f_vector,
    g_vector,
    gelfand_tsetlin,
    gkz_vector,
    halfspace_matrix_pair,
    hilbert_basis,
    h_star_polynomial,
    h_vector,
    intersect,
    interior_lattice_points,
    invert,
    isbounded,
    iscomplete,
    isembedded,
    isfeasible,
    isfulldimensional,
    isnormal,
    ispointed,
    ispure,
    isregular,
    issimple,
    issmooth,
    is_very_ample,
    k_skeleton,
    lattice_points,
    lattice_volume,
    lineality_dim,
    lineality_space,
    linear_equation_matrix,
    linear_inequality_matrix,
    linear_span,
    linear_symmetries,
    load,
    maximal_cells,
    maximal_cones,
    maximal_polyhedra,
    min_weights,
    minkowski_sum,
    newton_polytope,
    normalized_volume,
    normal_fan,
    normal_cone,
    nfacets,
    n_maximal_cells,
    n_maximal_cones,
    n_maximal_polyhedra,
    negbias,
    normal_vector,
    npoints,
    npolyhedra,
    nrays,
    nvertices,
    objective_function,
    optimal_vertex,
    optimal_value,
    orbit_polytope,
    points,
    point_matrix,
    polarize,
    polyhedra_of_dim,
    primitive_collections,
    print_constraints,
    product,
    project_full,
    pyramid,
    recession_cone,
    regular_triangulations,
    regular_triangulation,
    relative_interior_point,
    save,
    secondary_cone,
    secondary_polytope,
    simplex,
    solve_lp,
    starsubdivision,
    star_triangulations,
    subdivision_of_vertices,
    support_function,
    positive_hull,
    ray_indices,
    rays,
    upper_bound_f_vector,
    upper_bound_g_vector,
    upper_bound_h_vector,
    vector_matrix,
    vertices,
    vertices_and_rays,
    vertex_and_ray_indices,
    vertex_indices,
    vf_group,
    visualize,
    volume,
    *

include("helpers.jl")
include("iterators.jl")
include("Polyhedron/constructors.jl")
include("Cone/constructors.jl")
include("Cone/properties.jl")
include("Cone/standard_constructions.jl")
include("Polyhedron/properties.jl")
include("Polyhedron/standard_constructions.jl")
include("PolyhedralFan/constructors.jl")
include("PolyhedralFan/properties.jl")
include("PolyhedralFan/standard_constructions.jl")
include("PolyhedralComplex/constructors.jl")
include("PolyhedralComplex/properties.jl")
include("PolyhedralComplex/standard_constructions.jl")
include("SubdivisionOfPoints/constructors.jl")
include("SubdivisionOfPoints/properties.jl")
include("SubdivisionOfPoints/functions.jl")
include("LinearProgram.jl")
include("Groups.jl")
include("type_functions.jl")
include("Visualization.jl")
include("solving_integrally.jl")
include("triangulations.jl")

@deprecate bounded(Obj::Polyhedron) isbounded(Obj)

# Some temporary aliases to avoid breaking all current PRs
pm_cone(C::Cone) = pm_object(C)
pm_fan(PF::PolyhedralFan) = pm_object(PF)
pm_subdivision(SOP::SubdivisionOfPoints) = pm_object(SOP)
pm_polytope(P::Polyhedron) = pm_object(P)
