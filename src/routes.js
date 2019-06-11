import Dorm from './components/Dorm'
import Reserve from './components/Reserve'

export default [
    {path: '/', component: Dorm},
    {path: '/rezerwacja/:room', component: Reserve}
]