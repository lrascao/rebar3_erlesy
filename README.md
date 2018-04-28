Rebar3 erlesy plugin
=====

A rebar3 plugin for automatically generating state machine charts from finite state machines of your choosing

Build
-----

    $ rebar3 compile

Use
---

Add the plugin to your rebar config:

```erlang
{plugins, [
    { rebar3_erlesy, "1.0.0" }
]}.
```

Configure options (example below)

```erlang
{erlesy_opts, [
    {i, []},
    {filenames, [
        "src/statem_test.erl" | {"src/statem_test.erl", "graph/"}
    ]}
]}.
```

The `i` and `filenames` option values are relative to the app's location.
If not specified the output directory will be the same of the source filename,
if `filenames` list element is a tuple then the second element is the output directory
relative to the app's `_build` output directory.

```erlang
{provider_hooks, [
    {pre, [
        {compile, {erlesy, generate}},
        {clean, {erlesy, clean}}
    ]}
]}.
```

