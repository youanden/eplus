body {
  background-color: #fff;
  color: #333;
  font-family: verdana, arial, helvetica, sans-serif;
  font-size: 13px;
  line-height: 18px;
}

p, ol, ul, td {
  font-family: verdana, arial, helvetica, sans-serif;
  font-size: 13px;
  line-height: 18px;
}

pre {
  background-color: #eee;
  padding: 10px;
  font-size: 11px;
}

a {
  color: #000;
  &:visited {
    color: #666;
  }
  &:hover {
    color: #fff;
    background-color: #000;
  }
}

div {
  &.field, &.actions {
    margin-bottom: 10px;
  }
}

#notice {
  color: green;
}

.field_with_errors {
  padding: 2px;
  background-color: red;
  display: table;
}

#error_explanation {
  width: 450px;
  border: 2px solid red;
  padding: 7px;
  padding-bottom: 0;
  margin-bottom: 20px;
  background-color: #f0f0f0;
  h2 {
    text-align: left;
    font-weight: bold;
    padding: 5px 5px 5px 15px;
    font-size: 12px;
    margin: -7px;
    margin-bottom: 0px;
    background-color: #c00;
    color: #fff;
  }
  ul li {
    font-size: 12px;
    list-style: square;
  }
}
