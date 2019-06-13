import Dorm from './components/Dorm'
import Reserve from './components/Reserve'
import Admin from './components/Admin'

export default [
    {path: '/', name: 'home', component: Dorm},
    {path: '/rezerwacja/:dormName/:roomNumber', name: 'reserve', component: Reserve},
    {path: '/admin', name: 'admin', component: Admin}
]