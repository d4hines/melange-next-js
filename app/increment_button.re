[@bs.config {flags: [|"--preamble", "\"use client\";"|]}];

let fetcher = url =>
  Fetch.(
    fetchWithRequest(
      Request.makeWithInit(
        url,
        RequestInit.make(
          ~mode=SameOrigin,
          ~method=Post,
          ~credentials=Include,
          (),
        ),
      ),
    )
  )
  |> Js.Promise.then_(Fetch.Response.json);

[@react.component]
let make = (~timesClicked as _: int) => {
  <button onClick={_ev => {ignore(fetcher("/api"))}}>
    {React.string("Increment")}
  </button>;
};
