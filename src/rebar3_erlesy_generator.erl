-module(rebar3_erlesy_generator).

-export([generate/2,
         clean/2]).

-define(DEFAULT_OUTPUT_DIR, "graph").

%% ===================================================================
%% Public API
%% ===================================================================

-spec generate(rebar_app_info:t(),
               rebar_state:t()) -> ok.
generate(AppInfo, State) ->
    _AppDir = rebar_app_info:dir(AppInfo),
    _DepsDir = rebar_dir:deps_dir(State),
    AppOutDir = rebar_app_info:out_dir(AppInfo),

    Opts = rebar_app_info:opts(AppInfo),
    {ok, ErlesyOpts} = dict:find(erlesy_opts, Opts),
    rebar_api:debug("opts: ~p", [ErlesyOpts]),
    Filenames = proplists:get_value(filenames, ErlesyOpts, []),
    IncludePaths = proplists:get_value(i, ErlesyOpts, []),
    Mode = proplists:get_value(mode, ErlesyOpts, dot),

    lists:foreach(fun({Filename, OutputDir0}) ->
                        OutputDir = filename:join([AppOutDir, OutputDir0]),
                        rebar_api:debug("generating ~p graph out of ~p to ~p, i: ~p",
                                        [Mode, Filename, OutputDir, IncludePaths]),
                        ok = otp_parser:create_graph(Filename, IncludePaths, OutputDir, Mode);
                     (Filename) ->
                        rebar_api:debug("generating ~p graph out of ~p, i: ~p",
                                        [Mode, Filename, IncludePaths]),
                        ok = otp_parser:create_graph(Filename, IncludePaths, Mode)
                  end, Filenames),
    ok.

-spec clean(rebar_app_info:t(),
            rebar_state:t()) -> ok.
clean(AppInfo, State) ->
    _AppDir = rebar_app_info:dir(AppInfo),
    _DepsDir = rebar_dir:deps_dir(State),
    _AppOutDir = rebar_app_info:out_dir(AppInfo),

    Opts = rebar_app_info:opts(AppInfo),
    {ok, ErlesyOpts0} = dict:find(erlesy_opts, Opts),
    rebar_api:debug("opts: ~p", [ErlesyOpts0]),
    ok.

%% ===================================================================
%% Private API
%% ===================================================================
