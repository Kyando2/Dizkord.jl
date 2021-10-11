export OnMessageCreateContext,
    OnMessageCreate,
    OnInteractionCreate,
    OnReady,
    OnReadyContext,
    OnGuildCreate,
    OnGuildCreateContext,
    OnGuildUpdate,
    OnGuildUpdateContext

abstract type AbstractHandler end
abstract type AbstractContext end

macro ctx(U::Symbol, T::Symbol) 
    n = Symbol(lowercase(String(T)))
    k = Symbol(String(U)*"Context")
    quote
        struct $k <: AbstractContext
            $n::$T
        end
    end
end

macro handler(T::Symbol)
    n = Symbol("On"*String(T))
    quote
        struct $n <: AbstractHandler 
            f::Function
        end
    end
end

macro handlerctx(T::Symbol, C::Symbol)
    event_name = String(T)
    inner = Symbol(lowercase(String(C)))
    handler_name = Symbol("On"*String(T))
    context_name = Symbol(String(handler_name)*"Context")
    handler_doc = "Handler for [`$event_name`](@ref) event"
    context_doc = "Context passed to [`$handler_name`](@ref) handler"
    quote
        struct $handler_name <: AbstractHandler
            f::Function
        end
        struct $context_name <: AbstractContext 
            $inner::$C
        end
        @doc $handler_doc $handler_name
        @doc $context_doc $context_name
    end
end

@handlerctx(MessageCreate, Message)
@boilerplate OnMessageCreateContext :constructors :docs
@boilerplate OnMessageCreate :docs

struct OnChannelUpdateContext <: AbstractContext
    channel::Channel
end

struct OnGuildCreateContext <: AbstractContext
    guild::Guild
end

struct OnGuildUpdateContext <: AbstractContext
    guild::Guild
end

struct OnInteractionCreateContext <: AbstractContext
    int::Interaction
end

struct OnReadyContext <: AbstractContext 
    v::Int
    user::Optional{User}
    guilds::Vector{UnavailableGuild}
    session_id::String
    shard::Optional{Vector{Int}}
end
@boilerplate OnReadyContext :constructors

struct OnReady <: AbstractHandler 
    f::Function
end

struct OnInteractionCreate <: AbstractHandler 
    f::Function
    name::String
end

struct OnGuildCreate <: AbstractHandler 
    f::Function
end

struct OnGuildUpdate <: AbstractHandler 
    f::Function
end