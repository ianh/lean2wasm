import Lake
open Lake DSL

package lean2wasm {
  -- add package configuration options here
}

lean_lib Lean2Wasm {
  -- add library configuration options here
}

@[default_target]
lean_exe lean2wasm {
  root := `Lean2Wasm
}

lean_exe test where
  root := `Main

require importGraph from git "https://github.com/leanprover-community/import-graph" @ "v4.15.0"

script js (args : List String) do
  let out ← IO.Process.output {
    stdin  := .piped
    stdout := .piped
    stderr := .piped
    cmd    := "node"
    args   := (".lake/build/wasm/main.js" :: args).toArray
  }
  IO.print out.stdout
  IO.print out.stderr
  return out.exitCode
