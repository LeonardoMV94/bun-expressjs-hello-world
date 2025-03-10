import express, { type Request, type Response } from "express";

const app = express();
const port = process.env.PORT || 3000;

app.get("/", (req: Request, res: Response) => {
  res.status(200).json({"message":"Hello World!"});
});

app.listen(port, () => {
  console.log(`Listening on port ${port}...`);
});