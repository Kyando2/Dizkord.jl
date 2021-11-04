using Documenter, Dizkord

makedocs(;
    modules=[Dizkord],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
        "Types" => "types.md",
        "Client" => "client.md",
        "REST API" => "rest.md",
        "Helpers" => "helpers.md",
        "Handlers" => "events.md"
    ],
    repo="https://github.com/Humans-of-Julia/Dizkord.jl/blob/{commit}{path}#L{line}",
    sitename="Dizkord.jl",
    authors="Xh4H <sindur.esl@gmail.com>, christopher-dG <chrisadegraaf@gmail.com> Kyando <izawa.iori.tan@gmail.com>",
)

deploydocs(;
    repo="github.com/Humans-of-Julia/Dizkord.jl",
)
