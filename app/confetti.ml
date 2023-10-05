external init : unit -> unit = "init" [@@mel.module "./confetti_wrapper.ts"]

external make_confetti : unit -> unit Js.Promise.t = "make_confetti"
[@@mel.module "./confetti_wrapper.ts"]
