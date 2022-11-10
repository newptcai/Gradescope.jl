export test, print_result

function compare(ret::Real, expect::Real)
    return isapprox(ret, expect; rtol=0.05)
end

function compare((ret, expect))
    return compare(ret, expect)
end

function compare(ret::Vector{<:Number}, expect::Vector{<:Number})
    return all(compare.(zip(ret, expect)))
end

function compare(ret::Integer, expect::Integer)
    return ret == expect
end

function compare(ret, expect)
    return ret == expect
end

function test(expr, ret, expect, name, max_score=0.5)
    score = 0
    output = """Failed test:
    `$expr`.

    Expected result:
    $expect

    Actual result:
    $ret
    """
    if compare(ret, expect)
        score = max_scorce
        output = "Pass"
    end
    t = TestCase(name=name,
                 max_score=max_score, 
                 score = score,
                 output = output,
                 extra_data = Dict("ret"=>ret, "expect"=>expect))
    return t
end

function print_result(ret::Results)

    for t in ret.tests
        println(join(fill('=', 85)))
        println("name: $(t.name)")
        println("socre: $(t.score)")
        println("max score: $(t.max_score)")
        println(join(fill('-', 85)))
        println(t.output)
        println(join(fill('=', 85)))
    end
end
