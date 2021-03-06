/*
* Usage:
* import * as CodeGuessing16 from path/to/index.mjs
* CodeGuessing16.entry(args)
*/

//export { entry }

var BRANCH = 'Λ'

class BinaryTreeNode {
  constructor() {
    this.left = null;
    this.right = null;
  }
}

function zip(l1, l2) {
  return l1.map(function(k, i) {
    return [k, l2[i]]
  })
}

function fromPrefix(input) {
  stack = []
  for(var i = input.length-1; i >= 0; i--) {
    if(input[i] == '`') {
      var node = new BinaryTreeNode()
      node.right = stack.pop()
      node.left = stack.pop()
      stack.push(node)
    } else {
      stack.push(input[i])
    }
  }
  return stack.pop()
}

function fromPostfix(input) {
  stack = []
  for(var i = 0; i < input.length; i++) {
    if(input[i] == ',') {
      var node = new BinaryTreeNode()
      node.left = stack.pop()
      node.right = stack.pop()
      stack.push(node)
    } else {
      stack.push(input[i])
    }
  }
  return stack.pop()
}

function fromNestedHelper(tree) {
  var node = new BinaryTreeNode()
  if(!Array.isArray(tree))
    return tree
  node.right = fromNestedHelper(tree[0])
  node.left = fromNestedHelper(tree[1])
  return node
}

function fromNested(input) {
  var tree = eval(input)
  return fromNestedHelper(tree)
}

function fromASCIIHelper(grid, row, col) {
  if(grid[row][col] !== BRANCH) {
    return grid[row][col]
  }
  var node = new BinaryTreeNode()
  var leftR = row + 1
  var leftC = col + 1
  while(grid[leftR][leftC] == '\\') {
    leftR += 1
    leftC += 1
  }
  console.log(leftR, leftC, grid[leftR][leftC])
  node.left = fromASCIIHelper(grid, leftR, leftC)
  var rightR = row + 1
  var rightC = col - 1
  while(grid[rightR][rightC] == '/') {
    rightR += 1
    rightC -= 1
  }
  node.right = fromASCIIHelper(grid, rightR, rightC)
  return node
}

function fromASCII(input) {
  var grid = input.split("\n")
  console.log(grid)
  var col = grid[0].indexOf("Λ")

  console.log(col)
  return fromASCIIHelper(grid, 0,  col)
}

function toPrefix(tree) {
  if(tree instanceof BinaryTreeNode) {
    //console.log('happening', tree.left, tree.right)
    return '`' + toPrefix(tree.left) + toPrefix(tree.right)
  }
  return tree
}

function toPostfix(tree) {
  if(tree instanceof BinaryTreeNode) {
    return toPrefix(tree.left) + toPrefix(tree.right) + ','
  }
  return tree
}

function toNested(tree) {
  if(tree instanceof BinaryTreeNode)
    return "[" + toNested(tree.left) + ", " + toNested(tree.right) + "]"
  return "'" + tree + "'"
}

function depth(tree) {
  if(tree instanceof BinaryTreeNode)
    return 1 + Math.max(depth(tree.left), depth(tree.right))
  return 0
}



function toASCII(tree) {
  var dep = depth(tree)
  var dim = Math.pow(2, dep+2)
  var grid = []
  for(var i = 0; i < dim - 1; i++)
    grid.push(Array(dim).fill(' '))

  function helper(tree, depth, row, col) {
    if(tree instanceof BinaryTreeNode) {
      grid[row][col] = BRANCH;
      var len = Math.floor(Math.pow(2, depth+1)-1)
      for(var i = 1; i <= len; i++) {
        grid[row+i][col+i] = '\\'
        grid[row+i][col-i] = '/'
      }
      helper(tree.right, depth - 1, row+len+1, col+len+1)
      helper(tree.left, depth - 1, row+len+1, col-(len+1))
    } else {
      grid[row][col] = tree
    }
  }
  helper(tree, dep-1, 0, grid[0].length/2)
  // for(i of grid) {
  //   console.log(i.join(""))
  // }
  return grid.map(function(line) {
    return line.join("")
  }).join("\n")
}

function graphical(tree, canvasID, scale) {
  var cnv = document.getElementById(canvasID)
  var ctx = cnv.getContext("2d")
  ctx.font = scale + 'px serif'
  ctx.textAlign = 'center'
  ctx.textBaseline = 'middle'
  var dep = depth(tree)
  function helper(tree, depth, x, y) {
    if(tree instanceof BinaryTreeNode) {
      var len = Math.floor(scale*Math.pow(2, depth+1)-1)
      ctx.beginPath()
      // console.log(x,y)
      ctx.moveTo(x,y)
      ctx.lineTo(x-len, y+len)
      ctx.moveTo(x+len, y+len)
      ctx.lineTo(x,y)
      ctx.stroke()
      ctx.closePath()
      // console.log(tree)
      helper(tree.right, depth-1, x+len, y+len)
      helper(tree.left, depth-1, x-len, y+len)
    } else {
      ctx.beginPath()
      ctx.arc(x, y, scale, 0, 2 * Math.PI)
      ctx.fillStyle = "white"
      ctx.fill()
      ctx.stroke()
      ctx.closePath()
      ctx.fillStyle = "black"
      ctx.fillText(tree, x, y)
    }
  }
  helper(tree, dep, cnv.width/2, 0)
}

function entry(input, inputType = 'nestedArray', outputType = 'nestedArray', canvasID = "tree", scale = 10) {
  var inputTypes = {
    'prefix': fromPrefix,
    'postfix': fromPostfix,
    'nestedArray': fromNested,
    'ASCIIArt': fromASCII
  }
  var tree = inputTypes[inputType](input)
  var outputTypes = {
    'prefix': toPrefix,
    'postfix': toPostfix,
    'nestedArray': toNested,
    'ASCIIArt': toASCII
  }
  if(outputType == 'graphical') {
    graphical(tree, canvasID, scale)
    return undefined
  }
  return outputTypes[outputType](tree)
}
