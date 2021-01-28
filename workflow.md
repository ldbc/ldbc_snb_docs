## Benchmark workflow

### Generating the data set and substitution parameters

Project: [Datagen](https://github.com/ldbc/ldbc_snb_datagen)

1. Select the [serializers](https://github.com/ldbc/ldbc_snb_datagen/wiki/Data-Output) that suite the system-under-benchmark and generate the data set for the selected scale factor (e.g. SF1).
1. Datagen's [parameter generator component](https://github.com/ldbc/ldbc_snb_datagen/tree/stable/paramgenerator) generates substitution parameters from a data set. This is automatically invoked when [executing Datagen](https://github.com/ldbc/ldbc_snb_datagen/wiki/Compilation_Execution).

### Implementing a workload

Project: [Driver](https://github.com/ldbc/ldbc_snb_driver)

1. Build the driver project. You will need it both as a Maven dependency and as a standalone JAR file.
1. Create a new Java project and add the driver as a dependency.
1. Import the data set into your database.
1. Implement handlers for all operations.

The driver can operate in multiple modes. For most relevant modes are the following:

1. `create_validation_parameters`: generates validation data sets from a database.
2. `validate_database`: validates a database against an existing validation data sets (testing).
3. default: runs the performance measurements for the workload (benchmarking).

#### Generating the validation data set

_This step is only required if you are working on an implementation that you want to use as a basis for validation._

Run the driver with the selected configuration file. For an example, see the [PostgreSQL / BI](https://github.com/ldbc/ldbc_snb_implementations/blob/master/postgres/bi-create-validation-parameters.properties) config.

1. Provide the directory of the substitution parameters.
1. Provide the JAR file of the driver.
1. Provide the JAR file of an existing implementation (e.g. PostgreSQL).

Your validation set is created.

#### Validating an implementation

To perform this step, you should already have a validation data set. To get one, you can either generate it (see [the related step](https://github.com/ldbc/ldbc_snb_docs/wiki/Benchmark-workflow#generating-the-data-set-and-substitution-parameters)) or retrieve an existing one for your workload ([Interactive](https://github.com/ldbc/ldbc_snb_interactive_validation) or [BI](https://github.com/ldbc/ldbc_snb_bi_validation)).

Run the driver with the selected configuration file. For an example, see the [PostgreSQL / BI](https://github.com/ldbc/ldbc_snb_implementations/blob/master/postgres/bi-validate.properties) config.

#### Running the benchmark

Run the driver with the selected configuration file. For an example, see the [PostgreSQL / BI](https://github.com/ldbc/ldbc_snb_implementations/blob/master/postgres/bi-benchmark.properties) config. Make sure you set the workload's `parameters_dir` property to the appropriate `substitution_parameters` directory. Note that this needs to be produced separately for each scale factor by [the generator](https://github.com/ldbc/ldbc_snb_datagen/tree/master/paramgenerator).
For the Interactive workload, also set the `updates_dir` property to the generated `social_network` directory containing the `updateStream*` files.
