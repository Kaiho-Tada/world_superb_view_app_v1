import axios from "axios"
import applyCaseMiddleware from "axios-case-converter"

const options = {
  ignoreHeaders: true
}
const client = applyCaseMiddleware(axios.create({
  baseURL: "http://localhost:3001/api/v1",
  // headers: {
  //   'Content-Type': 'application/json',
  // },
  // responseType: 'json'
}), options)

export default client
