[@mel.config {flags: [|"--preamble", "\"use client\";"|]}];

external alert: string => unit = "alert";

[@react.component]
let make = () => {
  React.useEffect(() => {
    Confetti.init();
    None;
  });
  <>
    <button onClick={_ev => ignore(Confetti.make_confetti())}>
      {React.string("Throw Confetti")}
    </button>
    <br />
    <button onClick={_ev => alert("hello from external")}>
      {React.string("Say Hello External")}
    </button>
    <br />
    <button onClick={_ev => [%mel.raw {|alert("hello from mel.raw")|}]}>
      {React.string("Say Hello Raw")}
    </button>
    <br />
  </>;
};
