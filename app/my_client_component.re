[@bs.config {flags: [|"--preamble", "\"use client\";"|]}];

[@react.component]
let make = () => {
    <button onClick={(_ev) =>
        [%bs.raw {|alert("hello")|}]}>
        {React.string("Say Hello")}
    </button>;
};
