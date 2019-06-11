<template>
    <b-container>
        <h1 class="text-center">Formularz rezerwacji pokoju</h1>
        <h3 class="text-center">Dokonujesz rezerwacji pokoju numer: {{room}}</h3>
        <b-form @submit="onSubmit">
            <b-form-group id="form-input-group-1" label="Imię" label-for="form-input-1">
                <b-form-input
                        :state="$v.form.name.$dirty ? !$v.form.name.$error : null"
                        aria-describedby="input-1-live-feedback"
                        id="form-input-1"
                        placeholder="Podaj imię"
                        v-model.lazy.trim="$v.form.name.$model"
                ></b-form-input>

                <b-form-invalid-feedback id="input-1-live-feedback">
                    Imię musi posiadać więcej niż 2 znaki
                </b-form-invalid-feedback>
            </b-form-group>

            <b-form-group id="form-input-group-2" label="Nazwisko" label-for="form-input-2">
                <b-form-input
                        :state="$v.form.surname.$dirty ? !$v.form.surname.$error : null"
                        aria-describedby="input-2-live-feedback"
                        id="form-input-2"
                        placeholder="Podaj nazwisko"
                        v-model.lazy="$v.form.surname.$model"
                ></b-form-input>

                <b-form-invalid-feedback id="input-2-live-feedback">
                    Nazwisko musi posiadać więcej niż 3 znaki
                </b-form-invalid-feedback>
            </b-form-group>

            <b-form-group id="form-input-group-3" label="Numer indeksu" label-for="form-input-3">
                <b-form-input
                        :state="$v.form.indexNumber.$dirty ? !$v.form.indexNumber.$error : null"
                        aria-describedby="input-3-live-feedback"
                        id="form-input-3"
                        placeholder="Podaj numer indeksu"
                        v-model.number.lazy.trim="$v.form.indexNumber.$model"
                ></b-form-input>

                <b-form-invalid-feedback id="input-3-live-feedback">
                    Numer indeksu musi mieścić się w przedziale od 1 do 99999
                </b-form-invalid-feedback>
            </b-form-group>


            <b-form-group id="form-input-group-4" label="Adres e-mail" label-for="form-input-4">
                <b-form-input
                        :state="$v.form.email.$dirty ? !$v.form.email.$error : null"
                        aria-describedby="input-4-live-feedback"
                        id="form-input-4"
                        placeholder="Podaj swój adres e-mail"
                        v-model.lazy.trim="$v.form.email.$model"
                ></b-form-input>

                <b-form-invalid-feedback id="input-4-live-feedback">
                    Proszę wprowadzić poprawny adres e-mail
                </b-form-invalid-feedback>
            </b-form-group>

            <b-form-group id="form-input-group-5" label="Numer telefonu kontaktowego" label-for="form-input-5">
                <b-form-input
                        :state="$v.form.phone.$dirty ? !$v.form.phone.$error : null"
                        aria-describedby="input-5-live-feedback"
                        id="form-input-5"
                        placeholder="Podaj numer telefonu kontaktowego"
                        v-model.lazy.trim="$v.form.phone.$model"
                ></b-form-input>

                <b-form-invalid-feedback id="input-5-live-feedback">
                    Proszę wprowadzić poprawny numer telefonu
                </b-form-invalid-feedback>
            </b-form-group>

            <b-button :disabled="$v.form.$invalid" type="submit" variant="primary">Submit</b-button>
        </b-form>
    </b-container>
</template>

<script>
    import {required, helpers, between, integer, email} from 'vuelidate/lib/validators'

    const alpha = helpers.regex('alpha', /^[^0-9_!¡?÷¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]{2,}$/);
    const phone = helpers.regex('phone', /^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$/);
    export default {
        name: "Reserve",
        data() {
            return {
                room: this.$route.params.room,
                form: {
                    name: '',
                    surname: '',
                    indexNumber: null,
                    email: '',
                    phone: null
                }
            }
        },
        validations: {
            form: {
                name: {
                    required,
                    alpha
                },
                surname: {
                    required,
                    alpha
                },
                indexNumber: {
                    between: between(1, 99999),
                    integer
                },
                email: {
                    required,
                    email
                },
                phone: {
                    required,
                    phone
                }
            }
        },
        methods: {
            onSubmit() {
                postMessage()
                // Form submit logic
            }
        }
    }
</script>

<style scoped>

</style>