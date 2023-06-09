[@bs.config {flags: [|"--preamble", "\"use client\";"|]}];

external alert: string => unit = "alert";

[@react.component]
let make = () => {
  <>
    <button onClick={_ev => alert("hello from external")}>
      {React.string("Say Hello External")}
    </button>
    <br />
    <button onClick={_ev => [%bs.raw {|alert("hello from bs.raw")|}]}>
      {React.string("Say Hello Raw")}
    </button>
    <br />
  </>;
};
