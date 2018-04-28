-module(rebar3_erlesy).

-export([init/1]).

-spec init(rebar_state:t()) -> {ok, rebar_state:t()}.
init(State0) ->
    {ok, _} = application:ensure_all_started(erlesy),
    {ok, State1} = rebar3_erlesy_prv_generate:init(State0),
    {ok, State2} = rebar3_erlesy_prv_clean:init(State1),
    {ok, State2}.
