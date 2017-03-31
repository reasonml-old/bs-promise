(* Example usage:

   let prom1 = PromiseRe.make (fun resolve reject => resolve "hello");

   let prom2 = prom1
     |> PromiseRe.then_ (fun res => {Js.log res; 123})
     |> PromiseRe.then_ (fun res => print_int res); *)

(* 'a - type the promise will be resolved with
   'e - type the promise will be rejected with *)
type (+'a, +'e) t = ('a, 'e) Js.promise

external make : (('a -> unit) -> ('e -> unit) -> unit) -> ('a, 'e) t = "Promise" [@@bs.new]

external resolve : 'a -> ('a, 'e) t = "Promise.resolve" [@@bs.val]
external reject : 'e -> ('a, 'e) t = "Promise.reject" [@@bs.val]
external all : ('a, 'e) t array -> ('a array, 'e) t = "Promise.all" [@@bs.val]
external race : ('a, 'e) t array -> ('a, 'e) t = "Promise.race" [@@bs.val]

external then_ : ('a -> 'b) -> ('b, 'f) t = "then" [@@bs.send.pipe: ('a, 'e) t]
external (>>|): ('a, 'e) t -> ('a -> 'b [@bs]) -> ('b, 'f) t = "then" [@@bs.send]
[@@ocaml.deprecated "Obscure operators are discouraged. Please use `then_` instead"]
external andThen : ('a -> ('b, 'f) t) -> ('b, 'f) t = "then" [@@bs.send.pipe: ('a, 'e) t]
external (>>=) : ('a, 'e) t -> ('a -> ('b, 'f) t [@bs]) -> ('b, 'f) t = "then" [@@bs.send]
[@@ocaml.deprecated "Obscure operators are discouraged. Please use `andThen` instead"]

external catch : ('e -> unit) -> ('b, 'f) t = "catch" [@@bs.send.pipe: ('a, 'e) t]
external (>>?) : ('a, 'e) t -> ('e -> 'b [@bs]) -> ('b, 'f) t = "catch" [@@bs.send]
[@@ocaml.deprecated "Obscure operators are discouraged. Please use `or_` instead"]
external or_ : ('e -> 'b) -> ('b, 'f) t = "catch" [@@bs.send.pipe: ('a, 'e) t]
external orElse : ('e -> ('b, 'f) t) -> ('b, 'f) t = "catch" [@@bs.send.pipe: ('a, 'e) t]
