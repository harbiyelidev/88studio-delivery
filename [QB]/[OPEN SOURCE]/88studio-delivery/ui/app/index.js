const { createApp } = Vue;
import tablet from './pages/tablet/index.js';
import phone from './pages/phone/index.js';

const store = Vuex.createStore({
    state: {
        isTabletActive: false,
        isPhoneActive: false,
        isPhoneType: 1,
        Locales: {},
        Jobs: {},
        Cars: {},
        userDetail: {},
        userPhone: {},
    },
    mutations: {
        setIsTabletActive(state, value) {
            state.isTabletActive = value.isOpen;
            state.userDetail = value.userDetail;
        },
        setIsPhoneActive(state, value) {
            state.isPhoneActive = value.isOpen;
            state.isPhoneType = value.type;

            if (value.userPhone) {
                state.userPhone = value.userPhone;
            }
        },
        setLocales(state, language) {
            state.Locales = language;
        },
        setJobs(state, jobs) {
            state.Jobs = jobs;
        },
        setCars(state, cars) {
            state.Cars = cars;
        },
    },
    actions: {}
});

const app = createApp({
    data() {
        return {};
    },
    methods: {
        ...Vuex.mapMutations({
            setIsTabletActive: "setIsTabletActive",
            setIsPhoneActive: "setIsPhoneActive",
            updateJobDetail: "updateJobDetail",
            setLocales: "setLocales",
            setJobs: "setJobs",
            setCars: "setCars",
        }),
        messageHandler(event) {
            switch (event.data.action) {
                case "TOGGLE_TABLET":
                    this.setIsTabletActive(event.data.payload);
                    break;
                case "TOGGLE_PHONE":
                    this.setIsPhoneActive(event.data.payload);
                    break;
                case "SET_LANGUAGE":
                    this.setLocales(event.data.payload)
                    break
                case "SET_JOBS":
                    this.setJobs(event.data.payload)
                    break
                case "SET_CARS":
                    this.setCars(event.data.payload)
                    break
                default:
                    break;
            };
        }
    },
    components: {
        tablet,
        phone
    },
    computed: {
        ...Vuex.mapState({
            isTabletActive: state => state.isTabletActive,
            isPhoneActive: state => state.isPhoneActive,
        })
    },
    mounted() {
        window.addEventListener("message", this.messageHandler);
    },
    beforeDestroy() {
        window.removeEventListener("message", this.messageHandler);
    },
});

app.use(store).mount("#app");

var resourceName = "88studio-delivery";

if (window.GetParentResourceName) {
    resourceName = window.GetParentResourceName();
}


window.postNUI = async (name, data) => {
    try {
        const response = await fetch(`https://${resourceName}/${name}`, {
            method: "POST",
            mode: "cors",
            cache: "no-cache",
            credentials: "same-origin",
            headers: {
                "Content-Type": "application/json"
            },
            redirect: "follow",
            referrerPolicy: "no-referrer",
            body: JSON.stringify(data)
        });
        return !response.ok ? null : response.json();
    } catch (error) {
        // console.log(error)
    }
};
