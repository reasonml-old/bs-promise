(* Copyright (C) 2015-2016 Bloomberg Finance L.P.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * In addition to the permissions granted to you by the LGPL, you may combine
 * or link a "work that uses the Library" with a publicly distributed version
 * of this file to produce a combined library or application, then distribute
 * that combined work under the terms of your choosing, with no requirement
 * to comply with the obligations normally placed on you by section 4 of the
 * LGPL version 3 (or the corresponding section of a later version of the LGPL
 * should you choose to use a later version).
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. *)


(* 'a - type the promise will be resolved with
   'e - type the promise will be rejected with *)
type (+'a, +'e) t

external make : (('a -> unit) -> ('e -> unit) -> unit) -> ('a, 'e) t = "Promise" [@@bs.new]
external create : (('a -> unit [@bs]) -> ('e -> unit [@bs]) -> unit [@bs]) -> ('a, 'e) t = "Promise" [@@bs.new]
[@@ocaml.deprecated "Please use `make` instead"]

external resolve : 'a -> ('a, 'e) t = "Promise.resolve" [@@bs.val]
external reject : 'e -> ('a, 'e) t = "Promise.reject" [@@bs.val]
external all : ('a, 'e) t array -> ('a array, 'e) t = "Promise.all" [@@bs.val]
external race : ('a, 'e) t array -> ('a, 'e) t = "Promise.race" [@@bs.val]

external then_ : ('a -> 'b) -> ('b, 'f) t = "then" [@@bs.send.pipe: ('a, 'e) t]
external thenValue : ('a, 'e) t -> ('a -> 'b [@bs]) -> ('b, 'f) t = "then" [@@bs.send]
[@@ocaml.deprecated "Please use `then_` instead"]
external (>>|): ('a, 'e) t -> ('a -> 'b [@bs]) -> ('b, 'f) t = "then" [@@bs.send]
[@@ocaml.deprecated "Obscure operators are discouraged. Please use `then_` instead"]
external andThen : ('a -> ('b, 'f) t) -> ('b, 'f) t = "then" [@@bs.send.pipe: ('a, 'e) t]
external (>>=) : ('a, 'e) t -> ('a -> ('b, 'f) t [@bs]) -> ('b, 'f) t = "then" [@@bs.send]
[@@ocaml.deprecated "Obscure operators are discouraged. Please use `andThen` instead"]
external thenWithError : ('a, 'e) t -> ('a -> 'b [@bs]) -> ('e -> 'f [@bs]) -> ('b, 'f) t = "then" [@@bs.send]
[@@ocaml.deprecated "Obscure operators are discouraged. Please use a combination of `then_` and `catch` instead"]

external catch : ('e -> unit) -> ('b, 'f) t = "catch" [@@bs.send.pipe: ('a, 'e) t]
external (>>?) : ('a, 'e) t -> ('e -> 'b [@bs]) -> ('b, 'f) t = "catch" [@@bs.send]
[@@ocaml.deprecated "Obscure operators are discouraged. Please use `or_` instead"]
external or_ : ('e -> 'b) -> ('b, 'f) t = "catch" [@@bs.send.pipe: ('a, 'e) t]
external orElse : ('e -> ('b, 'f) t) -> ('b, 'f) t = "catch" [@@bs.send.pipe: ('a, 'e) t]
