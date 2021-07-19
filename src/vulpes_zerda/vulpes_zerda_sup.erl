%%%-------------------------------------------------------------------
%% @doc vulpes_zerda top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(vulpes_zerda_sup).
-behaviour(supervisor).
-export([start_link/0]).
-export([init/1]).
-define(SERVER, ?MODULE).

-spec start_link() -> { ok, pid() }.
start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%% sup_flags() = #{strategy => strategy(),         % optional
%%                 intensity => non_neg_integer(), % optional
%%                 period => pos_integer()}        % optional
%% child_spec() = #{id => child_id(),       % mandatory
%%                  start => mfargs(),      % mandatory
%%                  restart => restart(),   % optional
%%                  shutdown => shutdown(), % optional
%%                  type => worker(),       % optional
%%                  modules => modules()}   % optional
init([]) ->
    SupFlags = #{strategy => one_for_all,
                 intensity => 0,
                 period => 1},
    ChildSpecs = [#{id => hello_server,
                    start => {hello_server, start_link, []},
                    restart => permanent,
                    type => worker}],
    {ok, {SupFlags, ChildSpecs}}.

%% internal functions
