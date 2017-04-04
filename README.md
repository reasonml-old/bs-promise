### Official bindings to promises for [BuckleScript](https://github.com/BuckleTypes/bs-promise).

### Installation
npm: `npm install bs-promise`

### Usage

[Reason](http://facebook.github.io/reason/) syntax:

```reason
let prom1 = Bs_promise.make (fun resolve reject => resolve "hello");

let prom2 = prom1
  |> Bs_promise.then_ (fun res => {Js.log res; 123})
  |> Bs_promise.then_ (fun res => print_int res);
```

OCaml syntax:

```ocaml
let prom1 = Bs_promise.make (fun resolve reject -> resolve "hello")
let prom2 = prom1 
  |> Bs_promise.then_ (fun res -> Js.log res; 123)
  |> Bs_promise.then_ (fun res -> print_int res)
```

See more usage examples in [`test/`](https://github.com/BuckleTypes/bs-promise/blob/master/test/bs_promise_test.ml). The source is a [single file](https://github.com/BuckleTypes/bs-promise/blob/master/src/bs_promise.ml)!
