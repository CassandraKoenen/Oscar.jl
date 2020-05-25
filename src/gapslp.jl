const GAPStraightLine = Union{Vector{Int},            # e.g. [1, 2, 2, -1]
                              Tuple{Vector{Int},Int}, # e.g. ([1, 2], 2)
                              Vector{Vector{Int}}}    # return list

struct GAPSLProgram
    lines::Vector{GAPStraightLine}
    slp::Ref{SLProgram}
end

GAPSLProgram(lines::Vector{GAPStraightLine}=GAPStraightLine[]) =
    GAPSLProgram(lines, Ref{SLProgram}())

GAPSLProgram(lines::Vector) = foldl(pushline!, lines, init=GAPSLProgram())

invalid_list_error(line) = throw(ArgumentError("invalid line or list: $line"))

check_element(list) = iseven(length(list)) || invalid_list_error(list)

function pushline!(p::GAPSLProgram, line::Vector{Int})
    check_element(line)
    push!(p.lines, line)
    p
end

function pushline!(p::GAPSLProgram, line::Vector{Vector{Int}})
    for l in line
        check_element(l)
    end
    push!(p.lines, line)
    p
end

function pushline!(p::GAPSLProgram, line::Tuple{Vector{Int},Int})
    check_element(line[1])
    push!(p.lines, line)
    p
end

function pushline!(p::GAPSLProgram, line::Vector{Any})
    length(line) == 2 && line[1] isa Vector{Int} && line[2] isa Int ||
        invalid_list_error(line)
    pushline!(p, (line[1], line[2]))
end
