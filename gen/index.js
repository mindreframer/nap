const fs = require("fs");

class Generator {
  run() {
    let content = fs.readFileSync("test/sample_test.exs", "utf-8");
    Array.from(Array(50).keys()).forEach((i) => {
      const modname = `SampleTest${i}`;
      console.log(modname);

      const filename = `test/gen/sample${i}_test.exs`;

      let newcontent = content.replace("SampleTest", modname);

      fs.mkdirSync("test/gen", { recursive: true });
      fs.writeFileSync(filename, newcontent, "utf-8");
    });
  }
}

new Generator().run();
