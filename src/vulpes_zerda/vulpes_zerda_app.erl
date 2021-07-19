-module(vulpes_zerda_app).
-behaviour(application).
-export([start/2, stop/1]).

% Api functions
start(_StartType, _StartArgs) ->
	Dispatch = cowboy_router:compile([
		{'_', [
			{"/", index_handler, []}
		]}
	]),
	Port = 8008,
	{ok, _} = cowboy:start_clear(
        http, 
        [{port, Port}], 
        #{env => #{dispatch => Dispatch}
	}),
	vulpes_zerda_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
