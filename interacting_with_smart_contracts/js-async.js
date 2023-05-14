// promise: promises to returns a value
// three states: pending, resolved, rejected
// the following is the promise, then, catch syntax:

const promise = new Promise((resolve, reject) => {
	setTimeout(() => resolve(100), 1000)
	// setTimeout(() => reject("error"), 1000) // can also do reject
})

promise
	.then((val) => {
		console.log(val)
	})
	.catch((error) => {
		console.log(error)
	})
	.finally(() => {
		// will run no matter what happens
		console.log("finally")
	})

// async/await syntax:
const promise2 = new Promise((resolve, reject) => {
	setTimeout(() => resolve(100), 1000)
	// setTimeout(() => reject("error"), 1000) // can also do reject
})

async function func() {
	const result = await promise2
	console.log(result)
}

func()
