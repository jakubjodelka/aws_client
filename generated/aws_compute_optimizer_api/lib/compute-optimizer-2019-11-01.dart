// ignore_for_file: unused_element
// ignore_for_file: unused_field
// ignore_for_file: unused_import
// ignore_for_file: unused_local_variable
// ignore_for_file: unused_shown_name

import 'dart:convert';
import 'dart:typed_data';

import 'package:shared_aws_api/shared.dart' as _s;
import 'package:shared_aws_api/shared.dart'
    show
        rfc822ToJson,
        iso8601ToJson,
        unixTimestampToJson,
        nonNullableTimeStampFromJson,
        timeStampFromJson;

export 'package:shared_aws_api/shared.dart' show AwsClientCredentials;

/// AWS Compute Optimizer is a service that analyzes the configuration and
/// utilization metrics of your AWS compute resources, such as EC2 instances,
/// Auto Scaling groups, AWS Lambda functions, and Amazon EBS volumes. It
/// reports whether your resources are optimal, and generates optimization
/// recommendations to reduce the cost and improve the performance of your
/// workloads. Compute Optimizer also provides recent utilization metric data,
/// as well as projected utilization metric data for the recommendations, which
/// you can use to evaluate which recommendation provides the best
/// price-performance trade-off. The analysis of your usage patterns can help
/// you decide when to move or resize your running resources, and still meet
/// your performance and capacity requirements. For more information about
/// Compute Optimizer, including the required permissions to use the service,
/// see the <a
/// href="https://docs.aws.amazon.com/compute-optimizer/latest/ug/">AWS Compute
/// Optimizer User Guide</a>.
class ComputeOptimizer {
  final _s.JsonProtocol _protocol;
  ComputeOptimizer({
    required String region,
    _s.AwsClientCredentials? credentials,
    _s.AwsClientCredentialsProvider? credentialsProvider,
    _s.Client? client,
    String? endpointUrl,
  }) : _protocol = _s.JsonProtocol(
          client: client,
          service: _s.ServiceMetadata(
            endpointPrefix: 'compute-optimizer',
            signingName: 'compute-optimizer',
          ),
          region: region,
          credentials: credentials,
          credentialsProvider: credentialsProvider,
          endpointUrl: endpointUrl,
        );

  /// Closes the internal HTTP client if none was provided at creation.
  /// If a client was passed as a constructor argument, this becomes a noop.
  ///
  /// It's important to close all clients when it's done being used; failing to
  /// do so can cause the Dart process to hang.
  void close() {
    _protocol.close();
  }

  /// Describes recommendation export jobs created in the last seven days.
  ///
  /// Use the <code>ExportAutoScalingGroupRecommendations</code> or
  /// <code>ExportEC2InstanceRecommendations</code> actions to request an export
  /// of your recommendations. Then use the
  /// <code>DescribeRecommendationExportJobs</code> action to view your export
  /// jobs.
  ///
  /// May throw [OptInRequiredException].
  /// May throw [InternalServerException].
  /// May throw [ServiceUnavailableException].
  /// May throw [AccessDeniedException].
  /// May throw [InvalidParameterValueException].
  /// May throw [ResourceNotFoundException].
  /// May throw [MissingAuthenticationToken].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [filters] :
  /// An array of objects that describe a filter to return a more specific list
  /// of export jobs.
  ///
  /// Parameter [jobIds] :
  /// The identification numbers of the export jobs to return.
  ///
  /// An export job ID is returned when you create an export using the
  /// <code>ExportAutoScalingGroupRecommendations</code> or
  /// <code>ExportEC2InstanceRecommendations</code> actions.
  ///
  /// All export jobs created in the last seven days are returned if this
  /// parameter is omitted.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of export jobs to return with a single request.
  ///
  /// To retrieve the remaining results, make another request with the returned
  /// <code>NextToken</code> value.
  ///
  /// Parameter [nextToken] :
  /// The token to advance to the next page of export jobs.
  Future<DescribeRecommendationExportJobsResponse>
      describeRecommendationExportJobs({
    List<JobFilter>? filters,
    List<String>? jobIds,
    int? maxResults,
    String? nextToken,
  }) async {
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.0',
      'X-Amz-Target': 'ComputeOptimizerService.DescribeRecommendationExportJobs'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (filters != null) 'filters': filters,
        if (jobIds != null) 'jobIds': jobIds,
        if (maxResults != null) 'maxResults': maxResults,
        if (nextToken != null) 'nextToken': nextToken,
      },
    );

    return DescribeRecommendationExportJobsResponse.fromJson(jsonResponse.body);
  }

  /// Exports optimization recommendations for Auto Scaling groups.
  ///
  /// Recommendations are exported in a comma-separated values (.csv) file, and
  /// its metadata in a JavaScript Object Notation (.json) file, to an existing
  /// Amazon Simple Storage Service (Amazon S3) bucket that you specify. For
  /// more information, see <a
  /// href="https://docs.aws.amazon.com/compute-optimizer/latest/ug/exporting-recommendations.html">Exporting
  /// Recommendations</a> in the <i>Compute Optimizer User Guide</i>.
  ///
  /// You can have only one Auto Scaling group export job in progress per AWS
  /// Region.
  ///
  /// May throw [OptInRequiredException].
  /// May throw [InternalServerException].
  /// May throw [ServiceUnavailableException].
  /// May throw [AccessDeniedException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingAuthenticationToken].
  /// May throw [ThrottlingException].
  /// May throw [LimitExceededException].
  ///
  /// Parameter [s3DestinationConfig] :
  /// An object to specify the destination Amazon Simple Storage Service (Amazon
  /// S3) bucket name and key prefix for the export job.
  ///
  /// You must create the destination Amazon S3 bucket for your recommendations
  /// export before you create the export job. Compute Optimizer does not create
  /// the S3 bucket for you. After you create the S3 bucket, ensure that it has
  /// the required permission policy to allow Compute Optimizer to write the
  /// export file to it. If you plan to specify an object prefix when you create
  /// the export job, you must include the object prefix in the policy that you
  /// add to the S3 bucket. For more information, see <a
  /// href="https://docs.aws.amazon.com/compute-optimizer/latest/ug/create-s3-bucket-policy-for-compute-optimizer.html">Amazon
  /// S3 Bucket Policy for Compute Optimizer</a> in the <i>Compute Optimizer
  /// user guide</i>.
  ///
  /// Parameter [accountIds] :
  /// The IDs of the AWS accounts for which to export Auto Scaling group
  /// recommendations.
  ///
  /// If your account is the management account of an organization, use this
  /// parameter to specify the member accounts for which you want to export
  /// recommendations.
  ///
  /// This parameter cannot be specified together with the include member
  /// accounts parameter. The parameters are mutually exclusive.
  ///
  /// Recommendations for member accounts are not included in the export if this
  /// parameter, or the include member accounts parameter, is omitted.
  ///
  /// You can specify multiple account IDs per request.
  ///
  /// Parameter [fieldsToExport] :
  /// The recommendations data to include in the export file. For more
  /// information about the fields that can be exported, see <a
  /// href="https://docs.aws.amazon.com/compute-optimizer/latest/ug/exporting-recommendations.html#exported-files">Exported
  /// files</a> in the <i>Compute Optimizer User Guide</i>.
  ///
  /// Parameter [fileFormat] :
  /// The format of the export file.
  ///
  /// The only export file format currently supported is <code>Csv</code>.
  ///
  /// Parameter [filters] :
  /// An array of objects that describe a filter to export a more specific set
  /// of Auto Scaling group recommendations.
  ///
  /// Parameter [includeMemberAccounts] :
  /// Indicates whether to include recommendations for resources in all member
  /// accounts of the organization if your account is the management account of
  /// an organization.
  ///
  /// The member accounts must also be opted in to Compute Optimizer.
  ///
  /// Recommendations for member accounts of the organization are not included
  /// in the export file if this parameter is omitted.
  ///
  /// This parameter cannot be specified together with the account IDs
  /// parameter. The parameters are mutually exclusive.
  ///
  /// Recommendations for member accounts are not included in the export if this
  /// parameter, or the account IDs parameter, is omitted.
  Future<ExportAutoScalingGroupRecommendationsResponse>
      exportAutoScalingGroupRecommendations({
    required S3DestinationConfig s3DestinationConfig,
    List<String>? accountIds,
    List<ExportableAutoScalingGroupField>? fieldsToExport,
    FileFormat? fileFormat,
    List<Filter>? filters,
    bool? includeMemberAccounts,
  }) async {
    ArgumentError.checkNotNull(s3DestinationConfig, 's3DestinationConfig');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.0',
      'X-Amz-Target':
          'ComputeOptimizerService.ExportAutoScalingGroupRecommendations'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        's3DestinationConfig': s3DestinationConfig,
        if (accountIds != null) 'accountIds': accountIds,
        if (fieldsToExport != null)
          'fieldsToExport': fieldsToExport.map((e) => e.toValue()).toList(),
        if (fileFormat != null) 'fileFormat': fileFormat.toValue(),
        if (filters != null) 'filters': filters,
        if (includeMemberAccounts != null)
          'includeMemberAccounts': includeMemberAccounts,
      },
    );

    return ExportAutoScalingGroupRecommendationsResponse.fromJson(
        jsonResponse.body);
  }

  /// Exports optimization recommendations for Amazon EC2 instances.
  ///
  /// Recommendations are exported in a comma-separated values (.csv) file, and
  /// its metadata in a JavaScript Object Notation (.json) file, to an existing
  /// Amazon Simple Storage Service (Amazon S3) bucket that you specify. For
  /// more information, see <a
  /// href="https://docs.aws.amazon.com/compute-optimizer/latest/ug/exporting-recommendations.html">Exporting
  /// Recommendations</a> in the <i>Compute Optimizer User Guide</i>.
  ///
  /// You can have only one Amazon EC2 instance export job in progress per AWS
  /// Region.
  ///
  /// May throw [OptInRequiredException].
  /// May throw [InternalServerException].
  /// May throw [ServiceUnavailableException].
  /// May throw [AccessDeniedException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingAuthenticationToken].
  /// May throw [ThrottlingException].
  /// May throw [LimitExceededException].
  ///
  /// Parameter [s3DestinationConfig] :
  /// An object to specify the destination Amazon Simple Storage Service (Amazon
  /// S3) bucket name and key prefix for the export job.
  ///
  /// You must create the destination Amazon S3 bucket for your recommendations
  /// export before you create the export job. Compute Optimizer does not create
  /// the S3 bucket for you. After you create the S3 bucket, ensure that it has
  /// the required permission policy to allow Compute Optimizer to write the
  /// export file to it. If you plan to specify an object prefix when you create
  /// the export job, you must include the object prefix in the policy that you
  /// add to the S3 bucket. For more information, see <a
  /// href="https://docs.aws.amazon.com/compute-optimizer/latest/ug/create-s3-bucket-policy-for-compute-optimizer.html">Amazon
  /// S3 Bucket Policy for Compute Optimizer</a> in the <i>Compute Optimizer
  /// user guide</i>.
  ///
  /// Parameter [accountIds] :
  /// The IDs of the AWS accounts for which to export instance recommendations.
  ///
  /// If your account is the management account of an organization, use this
  /// parameter to specify the member accounts for which you want to export
  /// recommendations.
  ///
  /// This parameter cannot be specified together with the include member
  /// accounts parameter. The parameters are mutually exclusive.
  ///
  /// Recommendations for member accounts are not included in the export if this
  /// parameter, or the include member accounts parameter, is omitted.
  ///
  /// You can specify multiple account IDs per request.
  ///
  /// Parameter [fieldsToExport] :
  /// The recommendations data to include in the export file. For more
  /// information about the fields that can be exported, see <a
  /// href="https://docs.aws.amazon.com/compute-optimizer/latest/ug/exporting-recommendations.html#exported-files">Exported
  /// files</a> in the <i>Compute Optimizer User Guide</i>.
  ///
  /// Parameter [fileFormat] :
  /// The format of the export file.
  ///
  /// The only export file format currently supported is <code>Csv</code>.
  ///
  /// Parameter [filters] :
  /// An array of objects that describe a filter to export a more specific set
  /// of instance recommendations.
  ///
  /// Parameter [includeMemberAccounts] :
  /// Indicates whether to include recommendations for resources in all member
  /// accounts of the organization if your account is the management account of
  /// an organization.
  ///
  /// The member accounts must also be opted in to Compute Optimizer.
  ///
  /// Recommendations for member accounts of the organization are not included
  /// in the export file if this parameter is omitted.
  ///
  /// Recommendations for member accounts are not included in the export if this
  /// parameter, or the account IDs parameter, is omitted.
  Future<ExportEC2InstanceRecommendationsResponse>
      exportEC2InstanceRecommendations({
    required S3DestinationConfig s3DestinationConfig,
    List<String>? accountIds,
    List<ExportableInstanceField>? fieldsToExport,
    FileFormat? fileFormat,
    List<Filter>? filters,
    bool? includeMemberAccounts,
  }) async {
    ArgumentError.checkNotNull(s3DestinationConfig, 's3DestinationConfig');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.0',
      'X-Amz-Target': 'ComputeOptimizerService.ExportEC2InstanceRecommendations'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        's3DestinationConfig': s3DestinationConfig,
        if (accountIds != null) 'accountIds': accountIds,
        if (fieldsToExport != null)
          'fieldsToExport': fieldsToExport.map((e) => e.toValue()).toList(),
        if (fileFormat != null) 'fileFormat': fileFormat.toValue(),
        if (filters != null) 'filters': filters,
        if (includeMemberAccounts != null)
          'includeMemberAccounts': includeMemberAccounts,
      },
    );

    return ExportEC2InstanceRecommendationsResponse.fromJson(jsonResponse.body);
  }

  /// Returns Auto Scaling group recommendations.
  ///
  /// AWS Compute Optimizer generates recommendations for Amazon EC2 Auto
  /// Scaling groups that meet a specific set of requirements. For more
  /// information, see the <a
  /// href="https://docs.aws.amazon.com/compute-optimizer/latest/ug/requirements.html">Supported
  /// resources and requirements</a> in the <i>AWS Compute Optimizer User
  /// Guide</i>.
  ///
  /// May throw [OptInRequiredException].
  /// May throw [InternalServerException].
  /// May throw [ServiceUnavailableException].
  /// May throw [AccessDeniedException].
  /// May throw [InvalidParameterValueException].
  /// May throw [ResourceNotFoundException].
  /// May throw [MissingAuthenticationToken].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [accountIds] :
  /// The IDs of the AWS accounts for which to return Auto Scaling group
  /// recommendations.
  ///
  /// If your account is the management account of an organization, use this
  /// parameter to specify the member accounts for which you want to return Auto
  /// Scaling group recommendations.
  ///
  /// Only one account ID can be specified per request.
  ///
  /// Parameter [autoScalingGroupArns] :
  /// The Amazon Resource Name (ARN) of the Auto Scaling groups for which to
  /// return recommendations.
  ///
  /// Parameter [filters] :
  /// An array of objects that describe a filter that returns a more specific
  /// list of Auto Scaling group recommendations.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of Auto Scaling group recommendations to return with a
  /// single request.
  ///
  /// To retrieve the remaining results, make another request with the returned
  /// <code>NextToken</code> value.
  ///
  /// Parameter [nextToken] :
  /// The token to advance to the next page of Auto Scaling group
  /// recommendations.
  Future<GetAutoScalingGroupRecommendationsResponse>
      getAutoScalingGroupRecommendations({
    List<String>? accountIds,
    List<String>? autoScalingGroupArns,
    List<Filter>? filters,
    int? maxResults,
    String? nextToken,
  }) async {
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.0',
      'X-Amz-Target':
          'ComputeOptimizerService.GetAutoScalingGroupRecommendations'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (accountIds != null) 'accountIds': accountIds,
        if (autoScalingGroupArns != null)
          'autoScalingGroupArns': autoScalingGroupArns,
        if (filters != null) 'filters': filters,
        if (maxResults != null) 'maxResults': maxResults,
        if (nextToken != null) 'nextToken': nextToken,
      },
    );

    return GetAutoScalingGroupRecommendationsResponse.fromJson(
        jsonResponse.body);
  }

  /// Returns Amazon Elastic Block Store (Amazon EBS) volume recommendations.
  ///
  /// AWS Compute Optimizer generates recommendations for Amazon EBS volumes
  /// that meet a specific set of requirements. For more information, see the <a
  /// href="https://docs.aws.amazon.com/compute-optimizer/latest/ug/requirements.html">Supported
  /// resources and requirements</a> in the <i>AWS Compute Optimizer User
  /// Guide</i>.
  ///
  /// May throw [OptInRequiredException].
  /// May throw [InternalServerException].
  /// May throw [ServiceUnavailableException].
  /// May throw [AccessDeniedException].
  /// May throw [InvalidParameterValueException].
  /// May throw [ResourceNotFoundException].
  /// May throw [MissingAuthenticationToken].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [accountIds] :
  /// The IDs of the AWS accounts for which to return volume recommendations.
  ///
  /// If your account is the management account of an organization, use this
  /// parameter to specify the member accounts for which you want to return
  /// volume recommendations.
  ///
  /// Only one account ID can be specified per request.
  ///
  /// Parameter [filters] :
  /// An array of objects that describe a filter that returns a more specific
  /// list of volume recommendations.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of volume recommendations to return with a single
  /// request.
  ///
  /// To retrieve the remaining results, make another request with the returned
  /// <code>NextToken</code> value.
  ///
  /// Parameter [nextToken] :
  /// The token to advance to the next page of volume recommendations.
  ///
  /// Parameter [volumeArns] :
  /// The Amazon Resource Name (ARN) of the volumes for which to return
  /// recommendations.
  Future<GetEBSVolumeRecommendationsResponse> getEBSVolumeRecommendations({
    List<String>? accountIds,
    List<EBSFilter>? filters,
    int? maxResults,
    String? nextToken,
    List<String>? volumeArns,
  }) async {
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.0',
      'X-Amz-Target': 'ComputeOptimizerService.GetEBSVolumeRecommendations'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (accountIds != null) 'accountIds': accountIds,
        if (filters != null) 'filters': filters,
        if (maxResults != null) 'maxResults': maxResults,
        if (nextToken != null) 'nextToken': nextToken,
        if (volumeArns != null) 'volumeArns': volumeArns,
      },
    );

    return GetEBSVolumeRecommendationsResponse.fromJson(jsonResponse.body);
  }

  /// Returns Amazon EC2 instance recommendations.
  ///
  /// AWS Compute Optimizer generates recommendations for Amazon Elastic Compute
  /// Cloud (Amazon EC2) instances that meet a specific set of requirements. For
  /// more information, see the <a
  /// href="https://docs.aws.amazon.com/compute-optimizer/latest/ug/requirements.html">Supported
  /// resources and requirements</a> in the <i>AWS Compute Optimizer User
  /// Guide</i>.
  ///
  /// May throw [OptInRequiredException].
  /// May throw [InternalServerException].
  /// May throw [ServiceUnavailableException].
  /// May throw [AccessDeniedException].
  /// May throw [InvalidParameterValueException].
  /// May throw [ResourceNotFoundException].
  /// May throw [MissingAuthenticationToken].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [accountIds] :
  /// The IDs of the AWS accounts for which to return instance recommendations.
  ///
  /// If your account is the management account of an organization, use this
  /// parameter to specify the member accounts for which you want to return
  /// instance recommendations.
  ///
  /// Only one account ID can be specified per request.
  ///
  /// Parameter [filters] :
  /// An array of objects that describe a filter that returns a more specific
  /// list of instance recommendations.
  ///
  /// Parameter [instanceArns] :
  /// The Amazon Resource Name (ARN) of the instances for which to return
  /// recommendations.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of instance recommendations to return with a single
  /// request.
  ///
  /// To retrieve the remaining results, make another request with the returned
  /// <code>NextToken</code> value.
  ///
  /// Parameter [nextToken] :
  /// The token to advance to the next page of instance recommendations.
  Future<GetEC2InstanceRecommendationsResponse> getEC2InstanceRecommendations({
    List<String>? accountIds,
    List<Filter>? filters,
    List<String>? instanceArns,
    int? maxResults,
    String? nextToken,
  }) async {
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.0',
      'X-Amz-Target': 'ComputeOptimizerService.GetEC2InstanceRecommendations'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (accountIds != null) 'accountIds': accountIds,
        if (filters != null) 'filters': filters,
        if (instanceArns != null) 'instanceArns': instanceArns,
        if (maxResults != null) 'maxResults': maxResults,
        if (nextToken != null) 'nextToken': nextToken,
      },
    );

    return GetEC2InstanceRecommendationsResponse.fromJson(jsonResponse.body);
  }

  /// Returns the projected utilization metrics of Amazon EC2 instance
  /// recommendations.
  /// <note>
  /// The <code>Cpu</code> and <code>Memory</code> metrics are the only
  /// projected utilization metrics returned when you run this action.
  /// Additionally, the <code>Memory</code> metric is returned only for
  /// resources that have the unified CloudWatch agent installed on them. For
  /// more information, see <a
  /// href="https://docs.aws.amazon.com/compute-optimizer/latest/ug/metrics.html#cw-agent">Enabling
  /// Memory Utilization with the CloudWatch Agent</a>.
  /// </note>
  ///
  /// May throw [OptInRequiredException].
  /// May throw [InternalServerException].
  /// May throw [ServiceUnavailableException].
  /// May throw [AccessDeniedException].
  /// May throw [InvalidParameterValueException].
  /// May throw [ResourceNotFoundException].
  /// May throw [MissingAuthenticationToken].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [endTime] :
  /// The time stamp of the last projected metrics data point to return.
  ///
  /// Parameter [instanceArn] :
  /// The Amazon Resource Name (ARN) of the instances for which to return
  /// recommendation projected metrics.
  ///
  /// Parameter [period] :
  /// The granularity, in seconds, of the projected metrics data points.
  ///
  /// Parameter [startTime] :
  /// The time stamp of the first projected metrics data point to return.
  ///
  /// Parameter [stat] :
  /// The statistic of the projected metrics.
  Future<GetEC2RecommendationProjectedMetricsResponse>
      getEC2RecommendationProjectedMetrics({
    required DateTime endTime,
    required String instanceArn,
    required int period,
    required DateTime startTime,
    required MetricStatistic stat,
  }) async {
    ArgumentError.checkNotNull(endTime, 'endTime');
    ArgumentError.checkNotNull(instanceArn, 'instanceArn');
    ArgumentError.checkNotNull(period, 'period');
    ArgumentError.checkNotNull(startTime, 'startTime');
    ArgumentError.checkNotNull(stat, 'stat');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.0',
      'X-Amz-Target':
          'ComputeOptimizerService.GetEC2RecommendationProjectedMetrics'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'endTime': unixTimestampToJson(endTime),
        'instanceArn': instanceArn,
        'period': period,
        'startTime': unixTimestampToJson(startTime),
        'stat': stat.toValue(),
      },
    );

    return GetEC2RecommendationProjectedMetricsResponse.fromJson(
        jsonResponse.body);
  }

  /// Returns the enrollment (opt in) status of an account to the AWS Compute
  /// Optimizer service.
  ///
  /// If the account is the management account of an organization, this action
  /// also confirms the enrollment status of member accounts within the
  /// organization.
  ///
  /// May throw [InternalServerException].
  /// May throw [ServiceUnavailableException].
  /// May throw [AccessDeniedException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingAuthenticationToken].
  /// May throw [ThrottlingException].
  Future<GetEnrollmentStatusResponse> getEnrollmentStatus() async {
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.0',
      'X-Amz-Target': 'ComputeOptimizerService.GetEnrollmentStatus'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
    );

    return GetEnrollmentStatusResponse.fromJson(jsonResponse.body);
  }

  /// Returns AWS Lambda function recommendations.
  ///
  /// AWS Compute Optimizer generates recommendations for functions that meet a
  /// specific set of requirements. For more information, see the <a
  /// href="https://docs.aws.amazon.com/compute-optimizer/latest/ug/requirements.html">Supported
  /// resources and requirements</a> in the <i>AWS Compute Optimizer User
  /// Guide</i>.
  ///
  /// May throw [OptInRequiredException].
  /// May throw [InternalServerException].
  /// May throw [ServiceUnavailableException].
  /// May throw [AccessDeniedException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingAuthenticationToken].
  /// May throw [ThrottlingException].
  /// May throw [LimitExceededException].
  ///
  /// Parameter [accountIds] :
  /// The IDs of the AWS accounts for which to return function recommendations.
  ///
  /// If your account is the management account of an organization, use this
  /// parameter to specify the member accounts for which you want to return
  /// function recommendations.
  ///
  /// Only one account ID can be specified per request.
  ///
  /// Parameter [filters] :
  /// An array of objects that describe a filter that returns a more specific
  /// list of function recommendations.
  ///
  /// Parameter [functionArns] :
  /// The Amazon Resource Name (ARN) of the functions for which to return
  /// recommendations.
  ///
  /// You can specify a qualified or unqualified ARN. If you specify an
  /// unqualified ARN without a function version suffix, Compute Optimizer will
  /// return recommendations for the latest (<code>$LATEST</code>) version of
  /// the function. If you specify a qualified ARN with a version suffix,
  /// Compute Optimizer will return recommendations for the specified function
  /// version. For more information about using function versions, see <a
  /// href="https://docs.aws.amazon.com/lambda/latest/dg/configuration-versions.html#versioning-versions-using">Using
  /// versions</a> in the <i>AWS Lambda Developer Guide</i>.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of function recommendations to return with a single
  /// request.
  ///
  /// To retrieve the remaining results, make another request with the returned
  /// <code>NextToken</code> value.
  ///
  /// Parameter [nextToken] :
  /// The token to advance to the next page of function recommendations.
  Future<GetLambdaFunctionRecommendationsResponse>
      getLambdaFunctionRecommendations({
    List<String>? accountIds,
    List<LambdaFunctionRecommendationFilter>? filters,
    List<String>? functionArns,
    int? maxResults,
    String? nextToken,
  }) async {
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.0',
      'X-Amz-Target': 'ComputeOptimizerService.GetLambdaFunctionRecommendations'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (accountIds != null) 'accountIds': accountIds,
        if (filters != null) 'filters': filters,
        if (functionArns != null) 'functionArns': functionArns,
        if (maxResults != null) 'maxResults': maxResults,
        if (nextToken != null) 'nextToken': nextToken,
      },
    );

    return GetLambdaFunctionRecommendationsResponse.fromJson(jsonResponse.body);
  }

  /// Returns the optimization findings for an account.
  ///
  /// For example, it returns the number of Amazon EC2 instances in an account
  /// that are under-provisioned, over-provisioned, or optimized. It also
  /// returns the number of Auto Scaling groups in an account that are not
  /// optimized, or optimized.
  ///
  /// May throw [OptInRequiredException].
  /// May throw [InternalServerException].
  /// May throw [ServiceUnavailableException].
  /// May throw [AccessDeniedException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingAuthenticationToken].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [accountIds] :
  /// The IDs of the AWS accounts for which to return recommendation summaries.
  ///
  /// If your account is the management account of an organization, use this
  /// parameter to specify the member accounts for which you want to return
  /// recommendation summaries.
  ///
  /// Only one account ID can be specified per request.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of recommendation summaries to return with a single
  /// request.
  ///
  /// To retrieve the remaining results, make another request with the returned
  /// <code>NextToken</code> value.
  ///
  /// Parameter [nextToken] :
  /// The token to advance to the next page of recommendation summaries.
  Future<GetRecommendationSummariesResponse> getRecommendationSummaries({
    List<String>? accountIds,
    int? maxResults,
    String? nextToken,
  }) async {
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.0',
      'X-Amz-Target': 'ComputeOptimizerService.GetRecommendationSummaries'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (accountIds != null) 'accountIds': accountIds,
        if (maxResults != null) 'maxResults': maxResults,
        if (nextToken != null) 'nextToken': nextToken,
      },
    );

    return GetRecommendationSummariesResponse.fromJson(jsonResponse.body);
  }

  /// Updates the enrollment (opt in) status of an account to the AWS Compute
  /// Optimizer service.
  ///
  /// If the account is a management account of an organization, this action can
  /// also be used to enroll member accounts within the organization.
  ///
  /// May throw [InternalServerException].
  /// May throw [ServiceUnavailableException].
  /// May throw [AccessDeniedException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingAuthenticationToken].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [status] :
  /// The new enrollment status of the account.
  ///
  /// Accepted options are <code>Active</code> or <code>Inactive</code>. You
  /// will get an error if <code>Pending</code> or <code>Failed</code> are
  /// specified.
  ///
  /// Parameter [includeMemberAccounts] :
  /// Indicates whether to enroll member accounts of the organization if the
  /// your account is the management account of an organization.
  Future<UpdateEnrollmentStatusResponse> updateEnrollmentStatus({
    required Status status,
    bool? includeMemberAccounts,
  }) async {
    ArgumentError.checkNotNull(status, 'status');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.0',
      'X-Amz-Target': 'ComputeOptimizerService.UpdateEnrollmentStatus'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'status': status.toValue(),
        if (includeMemberAccounts != null)
          'includeMemberAccounts': includeMemberAccounts,
      },
    );

    return UpdateEnrollmentStatusResponse.fromJson(jsonResponse.body);
  }
}

/// Describes the configuration of an Auto Scaling group.
class AutoScalingGroupConfiguration {
  /// The desired capacity, or number of instances, for the Auto Scaling group.
  final int? desiredCapacity;

  /// The instance type for the Auto Scaling group.
  final String? instanceType;

  /// The maximum size, or maximum number of instances, for the Auto Scaling
  /// group.
  final int? maxSize;

  /// The minimum size, or minimum number of instances, for the Auto Scaling
  /// group.
  final int? minSize;

  AutoScalingGroupConfiguration({
    this.desiredCapacity,
    this.instanceType,
    this.maxSize,
    this.minSize,
  });
  factory AutoScalingGroupConfiguration.fromJson(Map<String, dynamic> json) {
    return AutoScalingGroupConfiguration(
      desiredCapacity: json['desiredCapacity'] as int?,
      instanceType: json['instanceType'] as String?,
      maxSize: json['maxSize'] as int?,
      minSize: json['minSize'] as int?,
    );
  }
}

/// Describes an Auto Scaling group recommendation.
class AutoScalingGroupRecommendation {
  /// The AWS account ID of the Auto Scaling group.
  final String? accountId;

  /// The Amazon Resource Name (ARN) of the Auto Scaling group.
  final String? autoScalingGroupArn;

  /// The name of the Auto Scaling group.
  final String? autoScalingGroupName;

  /// An array of objects that describe the current configuration of the Auto
  /// Scaling group.
  final AutoScalingGroupConfiguration? currentConfiguration;

  /// The finding classification for the Auto Scaling group.
  ///
  /// Findings for Auto Scaling groups include:
  ///
  /// <ul>
  /// <li>
  /// <b> <code>NotOptimized</code> </b>—An Auto Scaling group is considered not
  /// optimized when AWS Compute Optimizer identifies a recommendation that can
  /// provide better performance for your workload.
  /// </li>
  /// <li>
  /// <b> <code>Optimized</code> </b>—An Auto Scaling group is considered
  /// optimized when Compute Optimizer determines that the group is correctly
  /// provisioned to run your workload based on the chosen instance type. For
  /// optimized resources, Compute Optimizer might recommend a new generation
  /// instance type.
  /// </li>
  /// </ul>
  final Finding? finding;

  /// The time stamp of when the Auto Scaling group recommendation was last
  /// refreshed.
  final DateTime? lastRefreshTimestamp;

  /// The number of days for which utilization metrics were analyzed for the Auto
  /// Scaling group.
  final double? lookBackPeriodInDays;

  /// An array of objects that describe the recommendation options for the Auto
  /// Scaling group.
  final List<AutoScalingGroupRecommendationOption>? recommendationOptions;

  /// An array of objects that describe the utilization metrics of the Auto
  /// Scaling group.
  final List<UtilizationMetric>? utilizationMetrics;

  AutoScalingGroupRecommendation({
    this.accountId,
    this.autoScalingGroupArn,
    this.autoScalingGroupName,
    this.currentConfiguration,
    this.finding,
    this.lastRefreshTimestamp,
    this.lookBackPeriodInDays,
    this.recommendationOptions,
    this.utilizationMetrics,
  });
  factory AutoScalingGroupRecommendation.fromJson(Map<String, dynamic> json) {
    return AutoScalingGroupRecommendation(
      accountId: json['accountId'] as String?,
      autoScalingGroupArn: json['autoScalingGroupArn'] as String?,
      autoScalingGroupName: json['autoScalingGroupName'] as String?,
      currentConfiguration: json['currentConfiguration'] != null
          ? AutoScalingGroupConfiguration.fromJson(
              json['currentConfiguration'] as Map<String, dynamic>)
          : null,
      finding: (json['finding'] as String?)?.toFinding(),
      lastRefreshTimestamp: timeStampFromJson(json['lastRefreshTimestamp']),
      lookBackPeriodInDays: json['lookBackPeriodInDays'] as double?,
      recommendationOptions: (json['recommendationOptions'] as List?)
          ?.whereNotNull()
          .map((e) => AutoScalingGroupRecommendationOption.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      utilizationMetrics: (json['utilizationMetrics'] as List?)
          ?.whereNotNull()
          .map((e) => UtilizationMetric.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Describes a recommendation option for an Auto Scaling group.
class AutoScalingGroupRecommendationOption {
  /// An array of objects that describe an Auto Scaling group configuration.
  final AutoScalingGroupConfiguration? configuration;

  /// The performance risk of the Auto Scaling group configuration recommendation.
  ///
  /// Performance risk is the likelihood of the recommended instance type not
  /// meeting the performance requirement of your workload.
  ///
  /// The lowest performance risk is categorized as <code>0</code>, and the
  /// highest as <code>5</code>.
  final double? performanceRisk;

  /// An array of objects that describe the projected utilization metrics of the
  /// Auto Scaling group recommendation option.
  /// <note>
  /// The <code>Cpu</code> and <code>Memory</code> metrics are the only projected
  /// utilization metrics returned. Additionally, the <code>Memory</code> metric
  /// is returned only for resources that have the unified CloudWatch agent
  /// installed on them. For more information, see <a
  /// href="https://docs.aws.amazon.com/compute-optimizer/latest/ug/metrics.html#cw-agent">Enabling
  /// Memory Utilization with the CloudWatch Agent</a>.
  /// </note>
  final List<UtilizationMetric>? projectedUtilizationMetrics;

  /// The rank of the Auto Scaling group recommendation option.
  ///
  /// The top recommendation option is ranked as <code>1</code>.
  final int? rank;

  AutoScalingGroupRecommendationOption({
    this.configuration,
    this.performanceRisk,
    this.projectedUtilizationMetrics,
    this.rank,
  });
  factory AutoScalingGroupRecommendationOption.fromJson(
      Map<String, dynamic> json) {
    return AutoScalingGroupRecommendationOption(
      configuration: json['configuration'] != null
          ? AutoScalingGroupConfiguration.fromJson(
              json['configuration'] as Map<String, dynamic>)
          : null,
      performanceRisk: json['performanceRisk'] as double?,
      projectedUtilizationMetrics:
          (json['projectedUtilizationMetrics'] as List?)
              ?.whereNotNull()
              .map((e) => UtilizationMetric.fromJson(e as Map<String, dynamic>))
              .toList(),
      rank: json['rank'] as int?,
    );
  }
}

class DescribeRecommendationExportJobsResponse {
  /// The token to use to advance to the next page of export jobs.
  ///
  /// This value is null when there are no more pages of export jobs to return.
  final String? nextToken;

  /// An array of objects that describe recommendation export jobs.
  final List<RecommendationExportJob>? recommendationExportJobs;

  DescribeRecommendationExportJobsResponse({
    this.nextToken,
    this.recommendationExportJobs,
  });
  factory DescribeRecommendationExportJobsResponse.fromJson(
      Map<String, dynamic> json) {
    return DescribeRecommendationExportJobsResponse(
      nextToken: json['nextToken'] as String?,
      recommendationExportJobs: (json['recommendationExportJobs'] as List?)
          ?.whereNotNull()
          .map((e) =>
              RecommendationExportJob.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Describes a filter that returns a more specific list of Amazon Elastic Block
/// Store (Amazon EBS) volume recommendations.
///
/// This filter is used with the <code>GetEBSVolumeRecommendations</code>
/// action.
class EBSFilter {
  /// The name of the filter.
  ///
  /// Specify <code>Finding</code> to return recommendations with a specific
  /// finding classification (e.g., <code>Optimized</code>).
  final EBSFilterName? name;

  /// The value of the filter.
  ///
  /// The valid values are <code>Optimized</code>, or <code>NotOptimized</code>.
  final List<String>? values;

  EBSFilter({
    this.name,
    this.values,
  });
  Map<String, dynamic> toJson() {
    final name = this.name;
    final values = this.values;
    return {
      if (name != null) 'name': name.toValue(),
      if (values != null) 'values': values,
    };
  }
}

enum EBSFilterName {
  finding,
}

extension EBSFilterNameValueExtension on EBSFilterName {
  String toValue() {
    switch (this) {
      case EBSFilterName.finding:
        return 'Finding';
    }
  }
}

extension EBSFilterNameFromString on String {
  EBSFilterName toEBSFilterName() {
    switch (this) {
      case 'Finding':
        return EBSFilterName.finding;
    }
    throw Exception('$this is not known in enum EBSFilterName');
  }
}

enum EBSFinding {
  optimized,
  notOptimized,
}

extension EBSFindingValueExtension on EBSFinding {
  String toValue() {
    switch (this) {
      case EBSFinding.optimized:
        return 'Optimized';
      case EBSFinding.notOptimized:
        return 'NotOptimized';
    }
  }
}

extension EBSFindingFromString on String {
  EBSFinding toEBSFinding() {
    switch (this) {
      case 'Optimized':
        return EBSFinding.optimized;
      case 'NotOptimized':
        return EBSFinding.notOptimized;
    }
    throw Exception('$this is not known in enum EBSFinding');
  }
}

enum EBSMetricName {
  volumeReadOpsPerSecond,
  volumeWriteOpsPerSecond,
  volumeReadBytesPerSecond,
  volumeWriteBytesPerSecond,
}

extension EBSMetricNameValueExtension on EBSMetricName {
  String toValue() {
    switch (this) {
      case EBSMetricName.volumeReadOpsPerSecond:
        return 'VolumeReadOpsPerSecond';
      case EBSMetricName.volumeWriteOpsPerSecond:
        return 'VolumeWriteOpsPerSecond';
      case EBSMetricName.volumeReadBytesPerSecond:
        return 'VolumeReadBytesPerSecond';
      case EBSMetricName.volumeWriteBytesPerSecond:
        return 'VolumeWriteBytesPerSecond';
    }
  }
}

extension EBSMetricNameFromString on String {
  EBSMetricName toEBSMetricName() {
    switch (this) {
      case 'VolumeReadOpsPerSecond':
        return EBSMetricName.volumeReadOpsPerSecond;
      case 'VolumeWriteOpsPerSecond':
        return EBSMetricName.volumeWriteOpsPerSecond;
      case 'VolumeReadBytesPerSecond':
        return EBSMetricName.volumeReadBytesPerSecond;
      case 'VolumeWriteBytesPerSecond':
        return EBSMetricName.volumeWriteBytesPerSecond;
    }
    throw Exception('$this is not known in enum EBSMetricName');
  }
}

/// Describes a utilization metric of an Amazon Elastic Block Store (Amazon EBS)
/// volume.
///
/// Compare the utilization metric data of your resource against its projected
/// utilization metric data to determine the performance difference between your
/// current resource and the recommended option.
class EBSUtilizationMetric {
  /// The name of the utilization metric.
  ///
  /// The following utilization metrics are available:
  ///
  /// <ul>
  /// <li>
  /// <code>VolumeReadOpsPerSecond</code> - The completed read operations per
  /// second from the volume in a specified period of time.
  ///
  /// Unit: Count
  /// </li>
  /// <li>
  /// <code>VolumeWriteOpsPerSecond</code> - The completed write operations per
  /// second to the volume in a specified period of time.
  ///
  /// Unit: Count
  /// </li>
  /// <li>
  /// <code>VolumeReadBytesPerSecond</code> - The bytes read per second from the
  /// volume in a specified period of time.
  ///
  /// Unit: Bytes
  /// </li>
  /// <li>
  /// <code>VolumeWriteBytesPerSecond</code> - The bytes written to the volume in
  /// a specified period of time.
  ///
  /// Unit: Bytes
  /// </li>
  /// </ul>
  final EBSMetricName? name;

  /// The statistic of the utilization metric.
  ///
  /// The following statistics are available:
  ///
  /// <ul>
  /// <li>
  /// <code>Average</code> - This is the value of Sum / SampleCount during the
  /// specified period, or the average value observed during the specified period.
  /// </li>
  /// <li>
  /// <code>Maximum</code> - The highest value observed during the specified
  /// period. Use this value to determine high volumes of activity for your
  /// application.
  /// </li>
  /// </ul>
  final MetricStatistic? statistic;

  /// The value of the utilization metric.
  final double? value;

  EBSUtilizationMetric({
    this.name,
    this.statistic,
    this.value,
  });
  factory EBSUtilizationMetric.fromJson(Map<String, dynamic> json) {
    return EBSUtilizationMetric(
      name: (json['name'] as String?)?.toEBSMetricName(),
      statistic: (json['statistic'] as String?)?.toMetricStatistic(),
      value: json['value'] as double?,
    );
  }
}

class ExportAutoScalingGroupRecommendationsResponse {
  /// The identification number of the export job.
  ///
  /// Use the <code>DescribeRecommendationExportJobs</code> action, and specify
  /// the job ID to view the status of an export job.
  final String? jobId;

  /// An object that describes the destination Amazon S3 bucket of a
  /// recommendations export file.
  final S3Destination? s3Destination;

  ExportAutoScalingGroupRecommendationsResponse({
    this.jobId,
    this.s3Destination,
  });
  factory ExportAutoScalingGroupRecommendationsResponse.fromJson(
      Map<String, dynamic> json) {
    return ExportAutoScalingGroupRecommendationsResponse(
      jobId: json['jobId'] as String?,
      s3Destination: json['s3Destination'] != null
          ? S3Destination.fromJson(
              json['s3Destination'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Describes the destination of the recommendations export and metadata files.
class ExportDestination {
  /// An object that describes the destination Amazon Simple Storage Service
  /// (Amazon S3) bucket name and object keys of a recommendations export file,
  /// and its associated metadata file.
  final S3Destination? s3;

  ExportDestination({
    this.s3,
  });
  factory ExportDestination.fromJson(Map<String, dynamic> json) {
    return ExportDestination(
      s3: json['s3'] != null
          ? S3Destination.fromJson(json['s3'] as Map<String, dynamic>)
          : null,
    );
  }
}

class ExportEC2InstanceRecommendationsResponse {
  /// The identification number of the export job.
  ///
  /// Use the <code>DescribeRecommendationExportJobs</code> action, and specify
  /// the job ID to view the status of an export job.
  final String? jobId;

  /// An object that describes the destination Amazon S3 bucket of a
  /// recommendations export file.
  final S3Destination? s3Destination;

  ExportEC2InstanceRecommendationsResponse({
    this.jobId,
    this.s3Destination,
  });
  factory ExportEC2InstanceRecommendationsResponse.fromJson(
      Map<String, dynamic> json) {
    return ExportEC2InstanceRecommendationsResponse(
      jobId: json['jobId'] as String?,
      s3Destination: json['s3Destination'] != null
          ? S3Destination.fromJson(
              json['s3Destination'] as Map<String, dynamic>)
          : null,
    );
  }
}

enum ExportableAutoScalingGroupField {
  accountId,
  autoScalingGroupArn,
  autoScalingGroupName,
  finding,
  utilizationMetricsCpuMaximum,
  utilizationMetricsMemoryMaximum,
  utilizationMetricsEbsReadOpsPerSecondMaximum,
  utilizationMetricsEbsWriteOpsPerSecondMaximum,
  utilizationMetricsEbsReadBytesPerSecondMaximum,
  utilizationMetricsEbsWriteBytesPerSecondMaximum,
  lookbackPeriodInDays,
  currentConfigurationInstanceType,
  currentConfigurationDesiredCapacity,
  currentConfigurationMinSize,
  currentConfigurationMaxSize,
  currentOnDemandPrice,
  currentStandardOneYearNoUpfrontReservedPrice,
  currentStandardThreeYearNoUpfrontReservedPrice,
  currentVCpus,
  currentMemory,
  currentStorage,
  currentNetwork,
  recommendationOptionsConfigurationInstanceType,
  recommendationOptionsConfigurationDesiredCapacity,
  recommendationOptionsConfigurationMinSize,
  recommendationOptionsConfigurationMaxSize,
  recommendationOptionsProjectedUtilizationMetricsCpuMaximum,
  recommendationOptionsProjectedUtilizationMetricsMemoryMaximum,
  recommendationOptionsPerformanceRisk,
  recommendationOptionsOnDemandPrice,
  recommendationOptionsStandardOneYearNoUpfrontReservedPrice,
  recommendationOptionsStandardThreeYearNoUpfrontReservedPrice,
  recommendationOptionsVcpus,
  recommendationOptionsMemory,
  recommendationOptionsStorage,
  recommendationOptionsNetwork,
  lastRefreshTimestamp,
}

extension ExportableAutoScalingGroupFieldValueExtension
    on ExportableAutoScalingGroupField {
  String toValue() {
    switch (this) {
      case ExportableAutoScalingGroupField.accountId:
        return 'AccountId';
      case ExportableAutoScalingGroupField.autoScalingGroupArn:
        return 'AutoScalingGroupArn';
      case ExportableAutoScalingGroupField.autoScalingGroupName:
        return 'AutoScalingGroupName';
      case ExportableAutoScalingGroupField.finding:
        return 'Finding';
      case ExportableAutoScalingGroupField.utilizationMetricsCpuMaximum:
        return 'UtilizationMetricsCpuMaximum';
      case ExportableAutoScalingGroupField.utilizationMetricsMemoryMaximum:
        return 'UtilizationMetricsMemoryMaximum';
      case ExportableAutoScalingGroupField
          .utilizationMetricsEbsReadOpsPerSecondMaximum:
        return 'UtilizationMetricsEbsReadOpsPerSecondMaximum';
      case ExportableAutoScalingGroupField
          .utilizationMetricsEbsWriteOpsPerSecondMaximum:
        return 'UtilizationMetricsEbsWriteOpsPerSecondMaximum';
      case ExportableAutoScalingGroupField
          .utilizationMetricsEbsReadBytesPerSecondMaximum:
        return 'UtilizationMetricsEbsReadBytesPerSecondMaximum';
      case ExportableAutoScalingGroupField
          .utilizationMetricsEbsWriteBytesPerSecondMaximum:
        return 'UtilizationMetricsEbsWriteBytesPerSecondMaximum';
      case ExportableAutoScalingGroupField.lookbackPeriodInDays:
        return 'LookbackPeriodInDays';
      case ExportableAutoScalingGroupField.currentConfigurationInstanceType:
        return 'CurrentConfigurationInstanceType';
      case ExportableAutoScalingGroupField.currentConfigurationDesiredCapacity:
        return 'CurrentConfigurationDesiredCapacity';
      case ExportableAutoScalingGroupField.currentConfigurationMinSize:
        return 'CurrentConfigurationMinSize';
      case ExportableAutoScalingGroupField.currentConfigurationMaxSize:
        return 'CurrentConfigurationMaxSize';
      case ExportableAutoScalingGroupField.currentOnDemandPrice:
        return 'CurrentOnDemandPrice';
      case ExportableAutoScalingGroupField
          .currentStandardOneYearNoUpfrontReservedPrice:
        return 'CurrentStandardOneYearNoUpfrontReservedPrice';
      case ExportableAutoScalingGroupField
          .currentStandardThreeYearNoUpfrontReservedPrice:
        return 'CurrentStandardThreeYearNoUpfrontReservedPrice';
      case ExportableAutoScalingGroupField.currentVCpus:
        return 'CurrentVCpus';
      case ExportableAutoScalingGroupField.currentMemory:
        return 'CurrentMemory';
      case ExportableAutoScalingGroupField.currentStorage:
        return 'CurrentStorage';
      case ExportableAutoScalingGroupField.currentNetwork:
        return 'CurrentNetwork';
      case ExportableAutoScalingGroupField
          .recommendationOptionsConfigurationInstanceType:
        return 'RecommendationOptionsConfigurationInstanceType';
      case ExportableAutoScalingGroupField
          .recommendationOptionsConfigurationDesiredCapacity:
        return 'RecommendationOptionsConfigurationDesiredCapacity';
      case ExportableAutoScalingGroupField
          .recommendationOptionsConfigurationMinSize:
        return 'RecommendationOptionsConfigurationMinSize';
      case ExportableAutoScalingGroupField
          .recommendationOptionsConfigurationMaxSize:
        return 'RecommendationOptionsConfigurationMaxSize';
      case ExportableAutoScalingGroupField
          .recommendationOptionsProjectedUtilizationMetricsCpuMaximum:
        return 'RecommendationOptionsProjectedUtilizationMetricsCpuMaximum';
      case ExportableAutoScalingGroupField
          .recommendationOptionsProjectedUtilizationMetricsMemoryMaximum:
        return 'RecommendationOptionsProjectedUtilizationMetricsMemoryMaximum';
      case ExportableAutoScalingGroupField.recommendationOptionsPerformanceRisk:
        return 'RecommendationOptionsPerformanceRisk';
      case ExportableAutoScalingGroupField.recommendationOptionsOnDemandPrice:
        return 'RecommendationOptionsOnDemandPrice';
      case ExportableAutoScalingGroupField
          .recommendationOptionsStandardOneYearNoUpfrontReservedPrice:
        return 'RecommendationOptionsStandardOneYearNoUpfrontReservedPrice';
      case ExportableAutoScalingGroupField
          .recommendationOptionsStandardThreeYearNoUpfrontReservedPrice:
        return 'RecommendationOptionsStandardThreeYearNoUpfrontReservedPrice';
      case ExportableAutoScalingGroupField.recommendationOptionsVcpus:
        return 'RecommendationOptionsVcpus';
      case ExportableAutoScalingGroupField.recommendationOptionsMemory:
        return 'RecommendationOptionsMemory';
      case ExportableAutoScalingGroupField.recommendationOptionsStorage:
        return 'RecommendationOptionsStorage';
      case ExportableAutoScalingGroupField.recommendationOptionsNetwork:
        return 'RecommendationOptionsNetwork';
      case ExportableAutoScalingGroupField.lastRefreshTimestamp:
        return 'LastRefreshTimestamp';
    }
  }
}

extension ExportableAutoScalingGroupFieldFromString on String {
  ExportableAutoScalingGroupField toExportableAutoScalingGroupField() {
    switch (this) {
      case 'AccountId':
        return ExportableAutoScalingGroupField.accountId;
      case 'AutoScalingGroupArn':
        return ExportableAutoScalingGroupField.autoScalingGroupArn;
      case 'AutoScalingGroupName':
        return ExportableAutoScalingGroupField.autoScalingGroupName;
      case 'Finding':
        return ExportableAutoScalingGroupField.finding;
      case 'UtilizationMetricsCpuMaximum':
        return ExportableAutoScalingGroupField.utilizationMetricsCpuMaximum;
      case 'UtilizationMetricsMemoryMaximum':
        return ExportableAutoScalingGroupField.utilizationMetricsMemoryMaximum;
      case 'UtilizationMetricsEbsReadOpsPerSecondMaximum':
        return ExportableAutoScalingGroupField
            .utilizationMetricsEbsReadOpsPerSecondMaximum;
      case 'UtilizationMetricsEbsWriteOpsPerSecondMaximum':
        return ExportableAutoScalingGroupField
            .utilizationMetricsEbsWriteOpsPerSecondMaximum;
      case 'UtilizationMetricsEbsReadBytesPerSecondMaximum':
        return ExportableAutoScalingGroupField
            .utilizationMetricsEbsReadBytesPerSecondMaximum;
      case 'UtilizationMetricsEbsWriteBytesPerSecondMaximum':
        return ExportableAutoScalingGroupField
            .utilizationMetricsEbsWriteBytesPerSecondMaximum;
      case 'LookbackPeriodInDays':
        return ExportableAutoScalingGroupField.lookbackPeriodInDays;
      case 'CurrentConfigurationInstanceType':
        return ExportableAutoScalingGroupField.currentConfigurationInstanceType;
      case 'CurrentConfigurationDesiredCapacity':
        return ExportableAutoScalingGroupField
            .currentConfigurationDesiredCapacity;
      case 'CurrentConfigurationMinSize':
        return ExportableAutoScalingGroupField.currentConfigurationMinSize;
      case 'CurrentConfigurationMaxSize':
        return ExportableAutoScalingGroupField.currentConfigurationMaxSize;
      case 'CurrentOnDemandPrice':
        return ExportableAutoScalingGroupField.currentOnDemandPrice;
      case 'CurrentStandardOneYearNoUpfrontReservedPrice':
        return ExportableAutoScalingGroupField
            .currentStandardOneYearNoUpfrontReservedPrice;
      case 'CurrentStandardThreeYearNoUpfrontReservedPrice':
        return ExportableAutoScalingGroupField
            .currentStandardThreeYearNoUpfrontReservedPrice;
      case 'CurrentVCpus':
        return ExportableAutoScalingGroupField.currentVCpus;
      case 'CurrentMemory':
        return ExportableAutoScalingGroupField.currentMemory;
      case 'CurrentStorage':
        return ExportableAutoScalingGroupField.currentStorage;
      case 'CurrentNetwork':
        return ExportableAutoScalingGroupField.currentNetwork;
      case 'RecommendationOptionsConfigurationInstanceType':
        return ExportableAutoScalingGroupField
            .recommendationOptionsConfigurationInstanceType;
      case 'RecommendationOptionsConfigurationDesiredCapacity':
        return ExportableAutoScalingGroupField
            .recommendationOptionsConfigurationDesiredCapacity;
      case 'RecommendationOptionsConfigurationMinSize':
        return ExportableAutoScalingGroupField
            .recommendationOptionsConfigurationMinSize;
      case 'RecommendationOptionsConfigurationMaxSize':
        return ExportableAutoScalingGroupField
            .recommendationOptionsConfigurationMaxSize;
      case 'RecommendationOptionsProjectedUtilizationMetricsCpuMaximum':
        return ExportableAutoScalingGroupField
            .recommendationOptionsProjectedUtilizationMetricsCpuMaximum;
      case 'RecommendationOptionsProjectedUtilizationMetricsMemoryMaximum':
        return ExportableAutoScalingGroupField
            .recommendationOptionsProjectedUtilizationMetricsMemoryMaximum;
      case 'RecommendationOptionsPerformanceRisk':
        return ExportableAutoScalingGroupField
            .recommendationOptionsPerformanceRisk;
      case 'RecommendationOptionsOnDemandPrice':
        return ExportableAutoScalingGroupField
            .recommendationOptionsOnDemandPrice;
      case 'RecommendationOptionsStandardOneYearNoUpfrontReservedPrice':
        return ExportableAutoScalingGroupField
            .recommendationOptionsStandardOneYearNoUpfrontReservedPrice;
      case 'RecommendationOptionsStandardThreeYearNoUpfrontReservedPrice':
        return ExportableAutoScalingGroupField
            .recommendationOptionsStandardThreeYearNoUpfrontReservedPrice;
      case 'RecommendationOptionsVcpus':
        return ExportableAutoScalingGroupField.recommendationOptionsVcpus;
      case 'RecommendationOptionsMemory':
        return ExportableAutoScalingGroupField.recommendationOptionsMemory;
      case 'RecommendationOptionsStorage':
        return ExportableAutoScalingGroupField.recommendationOptionsStorage;
      case 'RecommendationOptionsNetwork':
        return ExportableAutoScalingGroupField.recommendationOptionsNetwork;
      case 'LastRefreshTimestamp':
        return ExportableAutoScalingGroupField.lastRefreshTimestamp;
    }
    throw Exception(
        '$this is not known in enum ExportableAutoScalingGroupField');
  }
}

enum ExportableInstanceField {
  accountId,
  instanceArn,
  instanceName,
  finding,
  lookbackPeriodInDays,
  currentInstanceType,
  utilizationMetricsCpuMaximum,
  utilizationMetricsMemoryMaximum,
  utilizationMetricsEbsReadOpsPerSecondMaximum,
  utilizationMetricsEbsWriteOpsPerSecondMaximum,
  utilizationMetricsEbsReadBytesPerSecondMaximum,
  utilizationMetricsEbsWriteBytesPerSecondMaximum,
  currentOnDemandPrice,
  currentStandardOneYearNoUpfrontReservedPrice,
  currentStandardThreeYearNoUpfrontReservedPrice,
  currentVCpus,
  currentMemory,
  currentStorage,
  currentNetwork,
  recommendationOptionsInstanceType,
  recommendationOptionsProjectedUtilizationMetricsCpuMaximum,
  recommendationOptionsProjectedUtilizationMetricsMemoryMaximum,
  recommendationOptionsPerformanceRisk,
  recommendationOptionsVcpus,
  recommendationOptionsMemory,
  recommendationOptionsStorage,
  recommendationOptionsNetwork,
  recommendationOptionsOnDemandPrice,
  recommendationOptionsStandardOneYearNoUpfrontReservedPrice,
  recommendationOptionsStandardThreeYearNoUpfrontReservedPrice,
  recommendationsSourcesRecommendationSourceArn,
  recommendationsSourcesRecommendationSourceType,
  lastRefreshTimestamp,
}

extension ExportableInstanceFieldValueExtension on ExportableInstanceField {
  String toValue() {
    switch (this) {
      case ExportableInstanceField.accountId:
        return 'AccountId';
      case ExportableInstanceField.instanceArn:
        return 'InstanceArn';
      case ExportableInstanceField.instanceName:
        return 'InstanceName';
      case ExportableInstanceField.finding:
        return 'Finding';
      case ExportableInstanceField.lookbackPeriodInDays:
        return 'LookbackPeriodInDays';
      case ExportableInstanceField.currentInstanceType:
        return 'CurrentInstanceType';
      case ExportableInstanceField.utilizationMetricsCpuMaximum:
        return 'UtilizationMetricsCpuMaximum';
      case ExportableInstanceField.utilizationMetricsMemoryMaximum:
        return 'UtilizationMetricsMemoryMaximum';
      case ExportableInstanceField.utilizationMetricsEbsReadOpsPerSecondMaximum:
        return 'UtilizationMetricsEbsReadOpsPerSecondMaximum';
      case ExportableInstanceField
          .utilizationMetricsEbsWriteOpsPerSecondMaximum:
        return 'UtilizationMetricsEbsWriteOpsPerSecondMaximum';
      case ExportableInstanceField
          .utilizationMetricsEbsReadBytesPerSecondMaximum:
        return 'UtilizationMetricsEbsReadBytesPerSecondMaximum';
      case ExportableInstanceField
          .utilizationMetricsEbsWriteBytesPerSecondMaximum:
        return 'UtilizationMetricsEbsWriteBytesPerSecondMaximum';
      case ExportableInstanceField.currentOnDemandPrice:
        return 'CurrentOnDemandPrice';
      case ExportableInstanceField.currentStandardOneYearNoUpfrontReservedPrice:
        return 'CurrentStandardOneYearNoUpfrontReservedPrice';
      case ExportableInstanceField
          .currentStandardThreeYearNoUpfrontReservedPrice:
        return 'CurrentStandardThreeYearNoUpfrontReservedPrice';
      case ExportableInstanceField.currentVCpus:
        return 'CurrentVCpus';
      case ExportableInstanceField.currentMemory:
        return 'CurrentMemory';
      case ExportableInstanceField.currentStorage:
        return 'CurrentStorage';
      case ExportableInstanceField.currentNetwork:
        return 'CurrentNetwork';
      case ExportableInstanceField.recommendationOptionsInstanceType:
        return 'RecommendationOptionsInstanceType';
      case ExportableInstanceField
          .recommendationOptionsProjectedUtilizationMetricsCpuMaximum:
        return 'RecommendationOptionsProjectedUtilizationMetricsCpuMaximum';
      case ExportableInstanceField
          .recommendationOptionsProjectedUtilizationMetricsMemoryMaximum:
        return 'RecommendationOptionsProjectedUtilizationMetricsMemoryMaximum';
      case ExportableInstanceField.recommendationOptionsPerformanceRisk:
        return 'RecommendationOptionsPerformanceRisk';
      case ExportableInstanceField.recommendationOptionsVcpus:
        return 'RecommendationOptionsVcpus';
      case ExportableInstanceField.recommendationOptionsMemory:
        return 'RecommendationOptionsMemory';
      case ExportableInstanceField.recommendationOptionsStorage:
        return 'RecommendationOptionsStorage';
      case ExportableInstanceField.recommendationOptionsNetwork:
        return 'RecommendationOptionsNetwork';
      case ExportableInstanceField.recommendationOptionsOnDemandPrice:
        return 'RecommendationOptionsOnDemandPrice';
      case ExportableInstanceField
          .recommendationOptionsStandardOneYearNoUpfrontReservedPrice:
        return 'RecommendationOptionsStandardOneYearNoUpfrontReservedPrice';
      case ExportableInstanceField
          .recommendationOptionsStandardThreeYearNoUpfrontReservedPrice:
        return 'RecommendationOptionsStandardThreeYearNoUpfrontReservedPrice';
      case ExportableInstanceField
          .recommendationsSourcesRecommendationSourceArn:
        return 'RecommendationsSourcesRecommendationSourceArn';
      case ExportableInstanceField
          .recommendationsSourcesRecommendationSourceType:
        return 'RecommendationsSourcesRecommendationSourceType';
      case ExportableInstanceField.lastRefreshTimestamp:
        return 'LastRefreshTimestamp';
    }
  }
}

extension ExportableInstanceFieldFromString on String {
  ExportableInstanceField toExportableInstanceField() {
    switch (this) {
      case 'AccountId':
        return ExportableInstanceField.accountId;
      case 'InstanceArn':
        return ExportableInstanceField.instanceArn;
      case 'InstanceName':
        return ExportableInstanceField.instanceName;
      case 'Finding':
        return ExportableInstanceField.finding;
      case 'LookbackPeriodInDays':
        return ExportableInstanceField.lookbackPeriodInDays;
      case 'CurrentInstanceType':
        return ExportableInstanceField.currentInstanceType;
      case 'UtilizationMetricsCpuMaximum':
        return ExportableInstanceField.utilizationMetricsCpuMaximum;
      case 'UtilizationMetricsMemoryMaximum':
        return ExportableInstanceField.utilizationMetricsMemoryMaximum;
      case 'UtilizationMetricsEbsReadOpsPerSecondMaximum':
        return ExportableInstanceField
            .utilizationMetricsEbsReadOpsPerSecondMaximum;
      case 'UtilizationMetricsEbsWriteOpsPerSecondMaximum':
        return ExportableInstanceField
            .utilizationMetricsEbsWriteOpsPerSecondMaximum;
      case 'UtilizationMetricsEbsReadBytesPerSecondMaximum':
        return ExportableInstanceField
            .utilizationMetricsEbsReadBytesPerSecondMaximum;
      case 'UtilizationMetricsEbsWriteBytesPerSecondMaximum':
        return ExportableInstanceField
            .utilizationMetricsEbsWriteBytesPerSecondMaximum;
      case 'CurrentOnDemandPrice':
        return ExportableInstanceField.currentOnDemandPrice;
      case 'CurrentStandardOneYearNoUpfrontReservedPrice':
        return ExportableInstanceField
            .currentStandardOneYearNoUpfrontReservedPrice;
      case 'CurrentStandardThreeYearNoUpfrontReservedPrice':
        return ExportableInstanceField
            .currentStandardThreeYearNoUpfrontReservedPrice;
      case 'CurrentVCpus':
        return ExportableInstanceField.currentVCpus;
      case 'CurrentMemory':
        return ExportableInstanceField.currentMemory;
      case 'CurrentStorage':
        return ExportableInstanceField.currentStorage;
      case 'CurrentNetwork':
        return ExportableInstanceField.currentNetwork;
      case 'RecommendationOptionsInstanceType':
        return ExportableInstanceField.recommendationOptionsInstanceType;
      case 'RecommendationOptionsProjectedUtilizationMetricsCpuMaximum':
        return ExportableInstanceField
            .recommendationOptionsProjectedUtilizationMetricsCpuMaximum;
      case 'RecommendationOptionsProjectedUtilizationMetricsMemoryMaximum':
        return ExportableInstanceField
            .recommendationOptionsProjectedUtilizationMetricsMemoryMaximum;
      case 'RecommendationOptionsPerformanceRisk':
        return ExportableInstanceField.recommendationOptionsPerformanceRisk;
      case 'RecommendationOptionsVcpus':
        return ExportableInstanceField.recommendationOptionsVcpus;
      case 'RecommendationOptionsMemory':
        return ExportableInstanceField.recommendationOptionsMemory;
      case 'RecommendationOptionsStorage':
        return ExportableInstanceField.recommendationOptionsStorage;
      case 'RecommendationOptionsNetwork':
        return ExportableInstanceField.recommendationOptionsNetwork;
      case 'RecommendationOptionsOnDemandPrice':
        return ExportableInstanceField.recommendationOptionsOnDemandPrice;
      case 'RecommendationOptionsStandardOneYearNoUpfrontReservedPrice':
        return ExportableInstanceField
            .recommendationOptionsStandardOneYearNoUpfrontReservedPrice;
      case 'RecommendationOptionsStandardThreeYearNoUpfrontReservedPrice':
        return ExportableInstanceField
            .recommendationOptionsStandardThreeYearNoUpfrontReservedPrice;
      case 'RecommendationsSourcesRecommendationSourceArn':
        return ExportableInstanceField
            .recommendationsSourcesRecommendationSourceArn;
      case 'RecommendationsSourcesRecommendationSourceType':
        return ExportableInstanceField
            .recommendationsSourcesRecommendationSourceType;
      case 'LastRefreshTimestamp':
        return ExportableInstanceField.lastRefreshTimestamp;
    }
    throw Exception('$this is not known in enum ExportableInstanceField');
  }
}

enum FileFormat {
  csv,
}

extension FileFormatValueExtension on FileFormat {
  String toValue() {
    switch (this) {
      case FileFormat.csv:
        return 'Csv';
    }
  }
}

extension FileFormatFromString on String {
  FileFormat toFileFormat() {
    switch (this) {
      case 'Csv':
        return FileFormat.csv;
    }
    throw Exception('$this is not known in enum FileFormat');
  }
}

/// Describes a filter that returns a more specific list of recommendations.
///
/// This filter is used with the <code>GetAutoScalingGroupRecommendations</code>
/// and <code>GetEC2InstanceRecommendations</code> actions.
class Filter {
  /// The name of the filter.
  ///
  /// Specify <code>Finding</code> to return recommendations with a specific
  /// finding classification (e.g., <code>Overprovisioned</code>).
  ///
  /// Specify <code>RecommendationSourceType</code> to return recommendations of a
  /// specific resource type (e.g., <code>AutoScalingGroup</code>).
  final FilterName? name;

  /// The value of the filter.
  ///
  /// The valid values for this parameter are as follows, depending on what you
  /// specify for the <code>name</code> parameter and the resource type that you
  /// wish to filter results for:
  ///
  /// <ul>
  /// <li>
  /// Specify <code>Optimized</code> or <code>NotOptimized</code> if you specified
  /// the <code>name</code> parameter as <code>Finding</code> and you want to
  /// filter results for Auto Scaling groups.
  /// </li>
  /// <li>
  /// Specify <code>Underprovisioned</code>, <code>Overprovisioned</code>, or
  /// <code>Optimized</code> if you specified the <code>name</code> parameter as
  /// <code>Finding</code> and you want to filter results for EC2 instances.
  /// </li>
  /// <li>
  /// Specify <code>Ec2Instance</code> or <code>AutoScalingGroup</code> if you
  /// specified the <code>name</code> parameter as
  /// <code>RecommendationSourceType</code>.
  /// </li>
  /// </ul>
  final List<String>? values;

  Filter({
    this.name,
    this.values,
  });
  Map<String, dynamic> toJson() {
    final name = this.name;
    final values = this.values;
    return {
      if (name != null) 'name': name.toValue(),
      if (values != null) 'values': values,
    };
  }
}

enum FilterName {
  finding,
  recommendationSourceType,
}

extension FilterNameValueExtension on FilterName {
  String toValue() {
    switch (this) {
      case FilterName.finding:
        return 'Finding';
      case FilterName.recommendationSourceType:
        return 'RecommendationSourceType';
    }
  }
}

extension FilterNameFromString on String {
  FilterName toFilterName() {
    switch (this) {
      case 'Finding':
        return FilterName.finding;
      case 'RecommendationSourceType':
        return FilterName.recommendationSourceType;
    }
    throw Exception('$this is not known in enum FilterName');
  }
}

enum Finding {
  underprovisioned,
  overprovisioned,
  optimized,
  notOptimized,
}

extension FindingValueExtension on Finding {
  String toValue() {
    switch (this) {
      case Finding.underprovisioned:
        return 'Underprovisioned';
      case Finding.overprovisioned:
        return 'Overprovisioned';
      case Finding.optimized:
        return 'Optimized';
      case Finding.notOptimized:
        return 'NotOptimized';
    }
  }
}

extension FindingFromString on String {
  Finding toFinding() {
    switch (this) {
      case 'Underprovisioned':
        return Finding.underprovisioned;
      case 'Overprovisioned':
        return Finding.overprovisioned;
      case 'Optimized':
        return Finding.optimized;
      case 'NotOptimized':
        return Finding.notOptimized;
    }
    throw Exception('$this is not known in enum Finding');
  }
}

enum FindingReasonCode {
  memoryOverprovisioned,
  memoryUnderprovisioned,
}

extension FindingReasonCodeValueExtension on FindingReasonCode {
  String toValue() {
    switch (this) {
      case FindingReasonCode.memoryOverprovisioned:
        return 'MemoryOverprovisioned';
      case FindingReasonCode.memoryUnderprovisioned:
        return 'MemoryUnderprovisioned';
    }
  }
}

extension FindingReasonCodeFromString on String {
  FindingReasonCode toFindingReasonCode() {
    switch (this) {
      case 'MemoryOverprovisioned':
        return FindingReasonCode.memoryOverprovisioned;
      case 'MemoryUnderprovisioned':
        return FindingReasonCode.memoryUnderprovisioned;
    }
    throw Exception('$this is not known in enum FindingReasonCode');
  }
}

class GetAutoScalingGroupRecommendationsResponse {
  /// An array of objects that describe Auto Scaling group recommendations.
  final List<AutoScalingGroupRecommendation>? autoScalingGroupRecommendations;

  /// An array of objects that describe errors of the request.
  ///
  /// For example, an error is returned if you request recommendations for an
  /// unsupported Auto Scaling group.
  final List<GetRecommendationError>? errors;

  /// The token to use to advance to the next page of Auto Scaling group
  /// recommendations.
  ///
  /// This value is null when there are no more pages of Auto Scaling group
  /// recommendations to return.
  final String? nextToken;

  GetAutoScalingGroupRecommendationsResponse({
    this.autoScalingGroupRecommendations,
    this.errors,
    this.nextToken,
  });
  factory GetAutoScalingGroupRecommendationsResponse.fromJson(
      Map<String, dynamic> json) {
    return GetAutoScalingGroupRecommendationsResponse(
      autoScalingGroupRecommendations:
          (json['autoScalingGroupRecommendations'] as List?)
              ?.whereNotNull()
              .map((e) => AutoScalingGroupRecommendation.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
      errors: (json['errors'] as List?)
          ?.whereNotNull()
          .map(
              (e) => GetRecommendationError.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['nextToken'] as String?,
    );
  }
}

class GetEBSVolumeRecommendationsResponse {
  /// An array of objects that describe errors of the request.
  ///
  /// For example, an error is returned if you request recommendations for an
  /// unsupported volume.
  final List<GetRecommendationError>? errors;

  /// The token to use to advance to the next page of volume recommendations.
  ///
  /// This value is null when there are no more pages of volume recommendations to
  /// return.
  final String? nextToken;

  /// An array of objects that describe volume recommendations.
  final List<VolumeRecommendation>? volumeRecommendations;

  GetEBSVolumeRecommendationsResponse({
    this.errors,
    this.nextToken,
    this.volumeRecommendations,
  });
  factory GetEBSVolumeRecommendationsResponse.fromJson(
      Map<String, dynamic> json) {
    return GetEBSVolumeRecommendationsResponse(
      errors: (json['errors'] as List?)
          ?.whereNotNull()
          .map(
              (e) => GetRecommendationError.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['nextToken'] as String?,
      volumeRecommendations: (json['volumeRecommendations'] as List?)
          ?.whereNotNull()
          .map((e) => VolumeRecommendation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class GetEC2InstanceRecommendationsResponse {
  /// An array of objects that describe errors of the request.
  ///
  /// For example, an error is returned if you request recommendations for an
  /// instance of an unsupported instance family.
  final List<GetRecommendationError>? errors;

  /// An array of objects that describe instance recommendations.
  final List<InstanceRecommendation>? instanceRecommendations;

  /// The token to use to advance to the next page of instance recommendations.
  ///
  /// This value is null when there are no more pages of instance recommendations
  /// to return.
  final String? nextToken;

  GetEC2InstanceRecommendationsResponse({
    this.errors,
    this.instanceRecommendations,
    this.nextToken,
  });
  factory GetEC2InstanceRecommendationsResponse.fromJson(
      Map<String, dynamic> json) {
    return GetEC2InstanceRecommendationsResponse(
      errors: (json['errors'] as List?)
          ?.whereNotNull()
          .map(
              (e) => GetRecommendationError.fromJson(e as Map<String, dynamic>))
          .toList(),
      instanceRecommendations: (json['instanceRecommendations'] as List?)
          ?.whereNotNull()
          .map(
              (e) => InstanceRecommendation.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['nextToken'] as String?,
    );
  }
}

class GetEC2RecommendationProjectedMetricsResponse {
  /// An array of objects that describe a projected metrics.
  final List<RecommendedOptionProjectedMetric>?
      recommendedOptionProjectedMetrics;

  GetEC2RecommendationProjectedMetricsResponse({
    this.recommendedOptionProjectedMetrics,
  });
  factory GetEC2RecommendationProjectedMetricsResponse.fromJson(
      Map<String, dynamic> json) {
    return GetEC2RecommendationProjectedMetricsResponse(
      recommendedOptionProjectedMetrics:
          (json['recommendedOptionProjectedMetrics'] as List?)
              ?.whereNotNull()
              .map((e) => RecommendedOptionProjectedMetric.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
    );
  }
}

class GetEnrollmentStatusResponse {
  /// Confirms the enrollment status of member accounts within the organization,
  /// if the account is a management account of an organization.
  final bool? memberAccountsEnrolled;

  /// The enrollment status of the account.
  final Status? status;

  /// The reason for the enrollment status of the account.
  ///
  /// For example, an account might show a status of <code>Pending</code> because
  /// member accounts of an organization require more time to be enrolled in the
  /// service.
  final String? statusReason;

  GetEnrollmentStatusResponse({
    this.memberAccountsEnrolled,
    this.status,
    this.statusReason,
  });
  factory GetEnrollmentStatusResponse.fromJson(Map<String, dynamic> json) {
    return GetEnrollmentStatusResponse(
      memberAccountsEnrolled: json['memberAccountsEnrolled'] as bool?,
      status: (json['status'] as String?)?.toStatus(),
      statusReason: json['statusReason'] as String?,
    );
  }
}

class GetLambdaFunctionRecommendationsResponse {
  /// An array of objects that describe function recommendations.
  final List<LambdaFunctionRecommendation>? lambdaFunctionRecommendations;

  /// The token to use to advance to the next page of function recommendations.
  ///
  /// This value is null when there are no more pages of function recommendations
  /// to return.
  final String? nextToken;

  GetLambdaFunctionRecommendationsResponse({
    this.lambdaFunctionRecommendations,
    this.nextToken,
  });
  factory GetLambdaFunctionRecommendationsResponse.fromJson(
      Map<String, dynamic> json) {
    return GetLambdaFunctionRecommendationsResponse(
      lambdaFunctionRecommendations: (json['lambdaFunctionRecommendations']
              as List?)
          ?.whereNotNull()
          .map((e) =>
              LambdaFunctionRecommendation.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['nextToken'] as String?,
    );
  }
}

/// Describes an error experienced when getting recommendations.
///
/// For example, an error is returned if you request recommendations for an
/// unsupported Auto Scaling group, or if you request recommendations for an
/// instance of an unsupported instance family.
class GetRecommendationError {
  /// The error code.
  final String? code;

  /// The ID of the error.
  final String? identifier;

  /// The message, or reason, for the error.
  final String? message;

  GetRecommendationError({
    this.code,
    this.identifier,
    this.message,
  });
  factory GetRecommendationError.fromJson(Map<String, dynamic> json) {
    return GetRecommendationError(
      code: json['code'] as String?,
      identifier: json['identifier'] as String?,
      message: json['message'] as String?,
    );
  }
}

class GetRecommendationSummariesResponse {
  /// The token to use to advance to the next page of recommendation summaries.
  ///
  /// This value is null when there are no more pages of recommendation summaries
  /// to return.
  final String? nextToken;

  /// An array of objects that summarize a recommendation.
  final List<RecommendationSummary>? recommendationSummaries;

  GetRecommendationSummariesResponse({
    this.nextToken,
    this.recommendationSummaries,
  });
  factory GetRecommendationSummariesResponse.fromJson(
      Map<String, dynamic> json) {
    return GetRecommendationSummariesResponse(
      nextToken: json['nextToken'] as String?,
      recommendationSummaries: (json['recommendationSummaries'] as List?)
          ?.whereNotNull()
          .map((e) => RecommendationSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Describes an Amazon EC2 instance recommendation.
class InstanceRecommendation {
  /// The AWS account ID of the instance.
  final String? accountId;

  /// The instance type of the current instance.
  final String? currentInstanceType;

  /// The finding classification for the instance.
  ///
  /// Findings for instances include:
  ///
  /// <ul>
  /// <li>
  /// <b> <code>Underprovisioned</code> </b>—An instance is considered
  /// under-provisioned when at least one specification of your instance, such as
  /// CPU, memory, or network, does not meet the performance requirements of your
  /// workload. Under-provisioned instances may lead to poor application
  /// performance.
  /// </li>
  /// <li>
  /// <b> <code>Overprovisioned</code> </b>—An instance is considered
  /// over-provisioned when at least one specification of your instance, such as
  /// CPU, memory, or network, can be sized down while still meeting the
  /// performance requirements of your workload, and no specification is
  /// under-provisioned. Over-provisioned instances may lead to unnecessary
  /// infrastructure cost.
  /// </li>
  /// <li>
  /// <b> <code>Optimized</code> </b>—An instance is considered optimized when all
  /// specifications of your instance, such as CPU, memory, and network, meet the
  /// performance requirements of your workload and is not over provisioned. An
  /// optimized instance runs your workloads with optimal performance and
  /// infrastructure cost. For optimized resources, AWS Compute Optimizer might
  /// recommend a new generation instance type.
  /// </li>
  /// </ul>
  final Finding? finding;

  /// The Amazon Resource Name (ARN) of the current instance.
  final String? instanceArn;

  /// The name of the current instance.
  final String? instanceName;

  /// The time stamp of when the instance recommendation was last refreshed.
  final DateTime? lastRefreshTimestamp;

  /// The number of days for which utilization metrics were analyzed for the
  /// instance.
  final double? lookBackPeriodInDays;

  /// An array of objects that describe the recommendation options for the
  /// instance.
  final List<InstanceRecommendationOption>? recommendationOptions;

  /// An array of objects that describe the source resource of the recommendation.
  final List<RecommendationSource>? recommendationSources;

  /// An array of objects that describe the utilization metrics of the instance.
  final List<UtilizationMetric>? utilizationMetrics;

  InstanceRecommendation({
    this.accountId,
    this.currentInstanceType,
    this.finding,
    this.instanceArn,
    this.instanceName,
    this.lastRefreshTimestamp,
    this.lookBackPeriodInDays,
    this.recommendationOptions,
    this.recommendationSources,
    this.utilizationMetrics,
  });
  factory InstanceRecommendation.fromJson(Map<String, dynamic> json) {
    return InstanceRecommendation(
      accountId: json['accountId'] as String?,
      currentInstanceType: json['currentInstanceType'] as String?,
      finding: (json['finding'] as String?)?.toFinding(),
      instanceArn: json['instanceArn'] as String?,
      instanceName: json['instanceName'] as String?,
      lastRefreshTimestamp: timeStampFromJson(json['lastRefreshTimestamp']),
      lookBackPeriodInDays: json['lookBackPeriodInDays'] as double?,
      recommendationOptions: (json['recommendationOptions'] as List?)
          ?.whereNotNull()
          .map((e) =>
              InstanceRecommendationOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      recommendationSources: (json['recommendationSources'] as List?)
          ?.whereNotNull()
          .map((e) => RecommendationSource.fromJson(e as Map<String, dynamic>))
          .toList(),
      utilizationMetrics: (json['utilizationMetrics'] as List?)
          ?.whereNotNull()
          .map((e) => UtilizationMetric.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Describes a recommendation option for an Amazon EC2 instance.
class InstanceRecommendationOption {
  /// The instance type of the instance recommendation.
  final String? instanceType;

  /// The performance risk of the instance recommendation option.
  ///
  /// Performance risk is the likelihood of the recommended instance type not
  /// meeting the performance requirement of your workload.
  ///
  /// The lowest performance risk is categorized as <code>0</code>, and the
  /// highest as <code>5</code>.
  final double? performanceRisk;

  /// An array of objects that describe the projected utilization metrics of the
  /// instance recommendation option.
  /// <note>
  /// The <code>Cpu</code> and <code>Memory</code> metrics are the only projected
  /// utilization metrics returned. Additionally, the <code>Memory</code> metric
  /// is returned only for resources that have the unified CloudWatch agent
  /// installed on them. For more information, see <a
  /// href="https://docs.aws.amazon.com/compute-optimizer/latest/ug/metrics.html#cw-agent">Enabling
  /// Memory Utilization with the CloudWatch Agent</a>.
  /// </note>
  final List<UtilizationMetric>? projectedUtilizationMetrics;

  /// The rank of the instance recommendation option.
  ///
  /// The top recommendation option is ranked as <code>1</code>.
  final int? rank;

  InstanceRecommendationOption({
    this.instanceType,
    this.performanceRisk,
    this.projectedUtilizationMetrics,
    this.rank,
  });
  factory InstanceRecommendationOption.fromJson(Map<String, dynamic> json) {
    return InstanceRecommendationOption(
      instanceType: json['instanceType'] as String?,
      performanceRisk: json['performanceRisk'] as double?,
      projectedUtilizationMetrics:
          (json['projectedUtilizationMetrics'] as List?)
              ?.whereNotNull()
              .map((e) => UtilizationMetric.fromJson(e as Map<String, dynamic>))
              .toList(),
      rank: json['rank'] as int?,
    );
  }
}

/// Describes a filter that returns a more specific list of recommendation
/// export jobs.
///
/// This filter is used with the <code>DescribeRecommendationExportJobs</code>
/// action.
class JobFilter {
  /// The name of the filter.
  ///
  /// Specify <code>ResourceType</code> to return export jobs of a specific
  /// resource type (e.g., <code>Ec2Instance</code>).
  ///
  /// Specify <code>JobStatus</code> to return export jobs with a specific status
  /// (e.g, <code>Complete</code>).
  final JobFilterName? name;

  /// The value of the filter.
  ///
  /// The valid values for this parameter are as follows, depending on what you
  /// specify for the <code>name</code> parameter:
  ///
  /// <ul>
  /// <li>
  /// Specify <code>Ec2Instance</code> or <code>AutoScalingGroup</code> if you
  /// specified the <code>name</code> parameter as <code>ResourceType</code>.
  /// There is no filter for EBS volumes because volume recommendations cannot be
  /// exported at this time.
  /// </li>
  /// <li>
  /// Specify <code>Queued</code>, <code>InProgress</code>, <code>Complete</code>,
  /// or <code>Failed</code> if you specified the <code>name</code> parameter as
  /// <code>JobStatus</code>.
  /// </li>
  /// </ul>
  final List<String>? values;

  JobFilter({
    this.name,
    this.values,
  });
  Map<String, dynamic> toJson() {
    final name = this.name;
    final values = this.values;
    return {
      if (name != null) 'name': name.toValue(),
      if (values != null) 'values': values,
    };
  }
}

enum JobFilterName {
  resourceType,
  jobStatus,
}

extension JobFilterNameValueExtension on JobFilterName {
  String toValue() {
    switch (this) {
      case JobFilterName.resourceType:
        return 'ResourceType';
      case JobFilterName.jobStatus:
        return 'JobStatus';
    }
  }
}

extension JobFilterNameFromString on String {
  JobFilterName toJobFilterName() {
    switch (this) {
      case 'ResourceType':
        return JobFilterName.resourceType;
      case 'JobStatus':
        return JobFilterName.jobStatus;
    }
    throw Exception('$this is not known in enum JobFilterName');
  }
}

enum JobStatus {
  queued,
  inProgress,
  complete,
  failed,
}

extension JobStatusValueExtension on JobStatus {
  String toValue() {
    switch (this) {
      case JobStatus.queued:
        return 'Queued';
      case JobStatus.inProgress:
        return 'InProgress';
      case JobStatus.complete:
        return 'Complete';
      case JobStatus.failed:
        return 'Failed';
    }
  }
}

extension JobStatusFromString on String {
  JobStatus toJobStatus() {
    switch (this) {
      case 'Queued':
        return JobStatus.queued;
      case 'InProgress':
        return JobStatus.inProgress;
      case 'Complete':
        return JobStatus.complete;
      case 'Failed':
        return JobStatus.failed;
    }
    throw Exception('$this is not known in enum JobStatus');
  }
}

enum LambdaFunctionMemoryMetricName {
  duration,
}

extension LambdaFunctionMemoryMetricNameValueExtension
    on LambdaFunctionMemoryMetricName {
  String toValue() {
    switch (this) {
      case LambdaFunctionMemoryMetricName.duration:
        return 'Duration';
    }
  }
}

extension LambdaFunctionMemoryMetricNameFromString on String {
  LambdaFunctionMemoryMetricName toLambdaFunctionMemoryMetricName() {
    switch (this) {
      case 'Duration':
        return LambdaFunctionMemoryMetricName.duration;
    }
    throw Exception(
        '$this is not known in enum LambdaFunctionMemoryMetricName');
  }
}

enum LambdaFunctionMemoryMetricStatistic {
  lowerBound,
  upperBound,
  expected,
}

extension LambdaFunctionMemoryMetricStatisticValueExtension
    on LambdaFunctionMemoryMetricStatistic {
  String toValue() {
    switch (this) {
      case LambdaFunctionMemoryMetricStatistic.lowerBound:
        return 'LowerBound';
      case LambdaFunctionMemoryMetricStatistic.upperBound:
        return 'UpperBound';
      case LambdaFunctionMemoryMetricStatistic.expected:
        return 'Expected';
    }
  }
}

extension LambdaFunctionMemoryMetricStatisticFromString on String {
  LambdaFunctionMemoryMetricStatistic toLambdaFunctionMemoryMetricStatistic() {
    switch (this) {
      case 'LowerBound':
        return LambdaFunctionMemoryMetricStatistic.lowerBound;
      case 'UpperBound':
        return LambdaFunctionMemoryMetricStatistic.upperBound;
      case 'Expected':
        return LambdaFunctionMemoryMetricStatistic.expected;
    }
    throw Exception(
        '$this is not known in enum LambdaFunctionMemoryMetricStatistic');
  }
}

/// Describes a projected utilization metric of an AWS Lambda function
/// recommendation option.
class LambdaFunctionMemoryProjectedMetric {
  /// The name of the projected utilization metric.
  final LambdaFunctionMemoryMetricName? name;

  /// The statistic of the projected utilization metric.
  final LambdaFunctionMemoryMetricStatistic? statistic;

  /// The values of the projected utilization metrics.
  final double? value;

  LambdaFunctionMemoryProjectedMetric({
    this.name,
    this.statistic,
    this.value,
  });
  factory LambdaFunctionMemoryProjectedMetric.fromJson(
      Map<String, dynamic> json) {
    return LambdaFunctionMemoryProjectedMetric(
      name: (json['name'] as String?)?.toLambdaFunctionMemoryMetricName(),
      statistic: (json['statistic'] as String?)
          ?.toLambdaFunctionMemoryMetricStatistic(),
      value: json['value'] as double?,
    );
  }
}

/// Describes a recommendation option for an AWS Lambda function.
class LambdaFunctionMemoryRecommendationOption {
  /// The memory size, in MB, of the function recommendation option.
  final int? memorySize;

  /// An array of objects that describe the projected utilization metrics of the
  /// function recommendation option.
  final List<LambdaFunctionMemoryProjectedMetric>? projectedUtilizationMetrics;

  /// The rank of the function recommendation option.
  ///
  /// The top recommendation option is ranked as <code>1</code>.
  final int? rank;

  LambdaFunctionMemoryRecommendationOption({
    this.memorySize,
    this.projectedUtilizationMetrics,
    this.rank,
  });
  factory LambdaFunctionMemoryRecommendationOption.fromJson(
      Map<String, dynamic> json) {
    return LambdaFunctionMemoryRecommendationOption(
      memorySize: json['memorySize'] as int?,
      projectedUtilizationMetrics:
          (json['projectedUtilizationMetrics'] as List?)
              ?.whereNotNull()
              .map((e) => LambdaFunctionMemoryProjectedMetric.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
      rank: json['rank'] as int?,
    );
  }
}

enum LambdaFunctionMetricName {
  duration,
  memory,
}

extension LambdaFunctionMetricNameValueExtension on LambdaFunctionMetricName {
  String toValue() {
    switch (this) {
      case LambdaFunctionMetricName.duration:
        return 'Duration';
      case LambdaFunctionMetricName.memory:
        return 'Memory';
    }
  }
}

extension LambdaFunctionMetricNameFromString on String {
  LambdaFunctionMetricName toLambdaFunctionMetricName() {
    switch (this) {
      case 'Duration':
        return LambdaFunctionMetricName.duration;
      case 'Memory':
        return LambdaFunctionMetricName.memory;
    }
    throw Exception('$this is not known in enum LambdaFunctionMetricName');
  }
}

enum LambdaFunctionMetricStatistic {
  maximum,
  average,
}

extension LambdaFunctionMetricStatisticValueExtension
    on LambdaFunctionMetricStatistic {
  String toValue() {
    switch (this) {
      case LambdaFunctionMetricStatistic.maximum:
        return 'Maximum';
      case LambdaFunctionMetricStatistic.average:
        return 'Average';
    }
  }
}

extension LambdaFunctionMetricStatisticFromString on String {
  LambdaFunctionMetricStatistic toLambdaFunctionMetricStatistic() {
    switch (this) {
      case 'Maximum':
        return LambdaFunctionMetricStatistic.maximum;
      case 'Average':
        return LambdaFunctionMetricStatistic.average;
    }
    throw Exception('$this is not known in enum LambdaFunctionMetricStatistic');
  }
}

/// Describes an AWS Lambda function recommendation.
class LambdaFunctionRecommendation {
  /// The AWS account ID of the function.
  final String? accountId;

  /// The amount of memory, in MB, that's allocated to the current function.
  final int? currentMemorySize;

  /// The finding classification for the function.
  ///
  /// Findings for functions include:
  ///
  /// <ul>
  /// <li>
  /// <b> <code>Optimized</code> </b> — The function is correctly provisioned to
  /// run your workload based on its current configuration and its utilization
  /// history. This finding classification does not include finding reason codes.
  /// </li>
  /// <li>
  /// <b> <code>NotOptimized</code> </b> — The function is performing at a higher
  /// level (over-provisioned) or at a lower level (under-provisioned) than
  /// required for your workload because its current configuration is not optimal.
  /// Over-provisioned resources might lead to unnecessary infrastructure cost,
  /// and under-provisioned resources might lead to poor application performance.
  /// This finding classification can include the
  /// <code>MemoryUnderprovisioned</code> and <code>MemoryUnderprovisioned</code>
  /// finding reason codes.
  /// </li>
  /// <li>
  /// <b> <code>Unavailable</code> </b> — Compute Optimizer was unable to generate
  /// a recommendation for the function. This could be because the function has
  /// not accumulated sufficient metric data, or the function does not qualify for
  /// a recommendation. This finding classification can include the
  /// <code>InsufficientData</code> and <code>Inconclusive</code> finding reason
  /// codes.
  /// <note>
  /// Functions with a finding of unavailable are not returned unless you specify
  /// the <code>filter</code> parameter with a value of <code>Unavailable</code>
  /// in your <code>GetLambdaFunctionRecommendations</code> request.
  /// </note> </li>
  /// </ul>
  final LambdaFunctionRecommendationFinding? finding;

  /// The reason for the finding classification of the function.
  /// <note>
  /// Functions that have a finding classification of <code>Optimized</code> don't
  /// have a finding reason code.
  /// </note>
  /// Reason codes include:
  ///
  /// <ul>
  /// <li>
  /// <b> <code>MemoryOverprovisioned</code> </b> — The function is
  /// over-provisioned when its memory configuration can be sized down while still
  /// meeting the performance requirements of your workload. An over-provisioned
  /// function might lead to unnecessary infrastructure cost. This finding reason
  /// code is part of the <code>NotOptimized</code> finding classification.
  /// </li>
  /// <li>
  /// <b> <code>MemoryUnderprovisioned</code> </b> — The function is
  /// under-provisioned when its memory configuration doesn't meet the performance
  /// requirements of the workload. An under-provisioned function might lead to
  /// poor application performance. This finding reason code is part of the
  /// <code>NotOptimized</code> finding classification.
  /// </li>
  /// <li>
  /// <b> <code>InsufficientData</code> </b> — The function does not have
  /// sufficient metric data for Compute Optimizer to generate a recommendation.
  /// For more information, see the <a
  /// href="https://docs.aws.amazon.com/compute-optimizer/latest/ug/requirements.html">Supported
  /// resources and requirements</a> in the <i>AWS Compute Optimizer User
  /// Guide</i>. This finding reason code is part of the <code>Unavailable</code>
  /// finding classification.
  /// </li>
  /// <li>
  /// <b> <code>Inconclusive</code> </b> — The function does not qualify for a
  /// recommendation, or there was an internal error. This finding reason code is
  /// part of the <code>Unavailable</code> finding classification.
  /// </li>
  /// </ul>
  final List<LambdaFunctionRecommendationFindingReasonCode>? findingReasonCodes;

  /// The Amazon Resource Name (ARN) of the current function.
  final String? functionArn;

  /// The version number of the current function.
  final String? functionVersion;

  /// The time stamp of when the function recommendation was last refreshed.
  final DateTime? lastRefreshTimestamp;

  /// The number of days for which utilization metrics were analyzed for the
  /// function.
  final double? lookbackPeriodInDays;

  /// An array of objects that describe the memory configuration recommendation
  /// options for the function.
  final List<LambdaFunctionMemoryRecommendationOption>?
      memorySizeRecommendationOptions;

  /// The number of times your function code was executed during the look-back
  /// period.
  final int? numberOfInvocations;

  /// An array of objects that describe the utilization metrics of the function.
  final List<LambdaFunctionUtilizationMetric>? utilizationMetrics;

  LambdaFunctionRecommendation({
    this.accountId,
    this.currentMemorySize,
    this.finding,
    this.findingReasonCodes,
    this.functionArn,
    this.functionVersion,
    this.lastRefreshTimestamp,
    this.lookbackPeriodInDays,
    this.memorySizeRecommendationOptions,
    this.numberOfInvocations,
    this.utilizationMetrics,
  });
  factory LambdaFunctionRecommendation.fromJson(Map<String, dynamic> json) {
    return LambdaFunctionRecommendation(
      accountId: json['accountId'] as String?,
      currentMemorySize: json['currentMemorySize'] as int?,
      finding:
          (json['finding'] as String?)?.toLambdaFunctionRecommendationFinding(),
      findingReasonCodes: (json['findingReasonCodes'] as List?)
          ?.whereNotNull()
          .map((e) =>
              (e as String).toLambdaFunctionRecommendationFindingReasonCode())
          .toList(),
      functionArn: json['functionArn'] as String?,
      functionVersion: json['functionVersion'] as String?,
      lastRefreshTimestamp: timeStampFromJson(json['lastRefreshTimestamp']),
      lookbackPeriodInDays: json['lookbackPeriodInDays'] as double?,
      memorySizeRecommendationOptions:
          (json['memorySizeRecommendationOptions'] as List?)
              ?.whereNotNull()
              .map((e) => LambdaFunctionMemoryRecommendationOption.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
      numberOfInvocations: json['numberOfInvocations'] as int?,
      utilizationMetrics: (json['utilizationMetrics'] as List?)
          ?.whereNotNull()
          .map((e) => LambdaFunctionUtilizationMetric.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Describes a filter that returns a more specific list of AWS Lambda function
/// recommendations.
class LambdaFunctionRecommendationFilter {
  /// The name of the filter.
  ///
  /// Specify <code>Finding</code> to return recommendations with a specific
  /// finding classification (e.g., <code>NotOptimized</code>).
  ///
  /// Specify <code>FindingReasonCode</code> to return recommendations with a
  /// specific finding reason code (e.g., <code>MemoryUnderprovisioned</code>).
  final LambdaFunctionRecommendationFilterName? name;

  /// The value of the filter.
  ///
  /// The valid values for this parameter are as follows, depending on what you
  /// specify for the <code>name</code> parameter:
  ///
  /// <ul>
  /// <li>
  /// Specify <code>Optimized</code>, <code>NotOptimized</code>, or
  /// <code>Unavailable</code> if you specified the <code>name</code> parameter as
  /// <code>Finding</code>.
  /// </li>
  /// <li>
  /// Specify <code>MemoryOverprovisioned</code>,
  /// <code>MemoryUnderprovisioned</code>, <code>InsufficientData</code>, or
  /// <code>Inconclusive</code> if you specified the <code>name</code> parameter
  /// as <code>FindingReasonCode</code>.
  /// </li>
  /// </ul>
  final List<String>? values;

  LambdaFunctionRecommendationFilter({
    this.name,
    this.values,
  });
  Map<String, dynamic> toJson() {
    final name = this.name;
    final values = this.values;
    return {
      if (name != null) 'name': name.toValue(),
      if (values != null) 'values': values,
    };
  }
}

enum LambdaFunctionRecommendationFilterName {
  finding,
  findingReasonCode,
}

extension LambdaFunctionRecommendationFilterNameValueExtension
    on LambdaFunctionRecommendationFilterName {
  String toValue() {
    switch (this) {
      case LambdaFunctionRecommendationFilterName.finding:
        return 'Finding';
      case LambdaFunctionRecommendationFilterName.findingReasonCode:
        return 'FindingReasonCode';
    }
  }
}

extension LambdaFunctionRecommendationFilterNameFromString on String {
  LambdaFunctionRecommendationFilterName
      toLambdaFunctionRecommendationFilterName() {
    switch (this) {
      case 'Finding':
        return LambdaFunctionRecommendationFilterName.finding;
      case 'FindingReasonCode':
        return LambdaFunctionRecommendationFilterName.findingReasonCode;
    }
    throw Exception(
        '$this is not known in enum LambdaFunctionRecommendationFilterName');
  }
}

enum LambdaFunctionRecommendationFinding {
  optimized,
  notOptimized,
  unavailable,
}

extension LambdaFunctionRecommendationFindingValueExtension
    on LambdaFunctionRecommendationFinding {
  String toValue() {
    switch (this) {
      case LambdaFunctionRecommendationFinding.optimized:
        return 'Optimized';
      case LambdaFunctionRecommendationFinding.notOptimized:
        return 'NotOptimized';
      case LambdaFunctionRecommendationFinding.unavailable:
        return 'Unavailable';
    }
  }
}

extension LambdaFunctionRecommendationFindingFromString on String {
  LambdaFunctionRecommendationFinding toLambdaFunctionRecommendationFinding() {
    switch (this) {
      case 'Optimized':
        return LambdaFunctionRecommendationFinding.optimized;
      case 'NotOptimized':
        return LambdaFunctionRecommendationFinding.notOptimized;
      case 'Unavailable':
        return LambdaFunctionRecommendationFinding.unavailable;
    }
    throw Exception(
        '$this is not known in enum LambdaFunctionRecommendationFinding');
  }
}

enum LambdaFunctionRecommendationFindingReasonCode {
  memoryOverprovisioned,
  memoryUnderprovisioned,
  insufficientData,
  inconclusive,
}

extension LambdaFunctionRecommendationFindingReasonCodeValueExtension
    on LambdaFunctionRecommendationFindingReasonCode {
  String toValue() {
    switch (this) {
      case LambdaFunctionRecommendationFindingReasonCode.memoryOverprovisioned:
        return 'MemoryOverprovisioned';
      case LambdaFunctionRecommendationFindingReasonCode.memoryUnderprovisioned:
        return 'MemoryUnderprovisioned';
      case LambdaFunctionRecommendationFindingReasonCode.insufficientData:
        return 'InsufficientData';
      case LambdaFunctionRecommendationFindingReasonCode.inconclusive:
        return 'Inconclusive';
    }
  }
}

extension LambdaFunctionRecommendationFindingReasonCodeFromString on String {
  LambdaFunctionRecommendationFindingReasonCode
      toLambdaFunctionRecommendationFindingReasonCode() {
    switch (this) {
      case 'MemoryOverprovisioned':
        return LambdaFunctionRecommendationFindingReasonCode
            .memoryOverprovisioned;
      case 'MemoryUnderprovisioned':
        return LambdaFunctionRecommendationFindingReasonCode
            .memoryUnderprovisioned;
      case 'InsufficientData':
        return LambdaFunctionRecommendationFindingReasonCode.insufficientData;
      case 'Inconclusive':
        return LambdaFunctionRecommendationFindingReasonCode.inconclusive;
    }
    throw Exception(
        '$this is not known in enum LambdaFunctionRecommendationFindingReasonCode');
  }
}

/// Describes a utilization metric of an AWS Lambda function.
class LambdaFunctionUtilizationMetric {
  /// The name of the utilization metric.
  final LambdaFunctionMetricName? name;

  /// The statistic of the utilization metric.
  final LambdaFunctionMetricStatistic? statistic;

  /// The value of the utilization metric.
  final double? value;

  LambdaFunctionUtilizationMetric({
    this.name,
    this.statistic,
    this.value,
  });
  factory LambdaFunctionUtilizationMetric.fromJson(Map<String, dynamic> json) {
    return LambdaFunctionUtilizationMetric(
      name: (json['name'] as String?)?.toLambdaFunctionMetricName(),
      statistic:
          (json['statistic'] as String?)?.toLambdaFunctionMetricStatistic(),
      value: json['value'] as double?,
    );
  }
}

enum MetricName {
  cpu,
  memory,
  ebsReadOpsPerSecond,
  ebsWriteOpsPerSecond,
  ebsReadBytesPerSecond,
  ebsWriteBytesPerSecond,
}

extension MetricNameValueExtension on MetricName {
  String toValue() {
    switch (this) {
      case MetricName.cpu:
        return 'Cpu';
      case MetricName.memory:
        return 'Memory';
      case MetricName.ebsReadOpsPerSecond:
        return 'EBS_READ_OPS_PER_SECOND';
      case MetricName.ebsWriteOpsPerSecond:
        return 'EBS_WRITE_OPS_PER_SECOND';
      case MetricName.ebsReadBytesPerSecond:
        return 'EBS_READ_BYTES_PER_SECOND';
      case MetricName.ebsWriteBytesPerSecond:
        return 'EBS_WRITE_BYTES_PER_SECOND';
    }
  }
}

extension MetricNameFromString on String {
  MetricName toMetricName() {
    switch (this) {
      case 'Cpu':
        return MetricName.cpu;
      case 'Memory':
        return MetricName.memory;
      case 'EBS_READ_OPS_PER_SECOND':
        return MetricName.ebsReadOpsPerSecond;
      case 'EBS_WRITE_OPS_PER_SECOND':
        return MetricName.ebsWriteOpsPerSecond;
      case 'EBS_READ_BYTES_PER_SECOND':
        return MetricName.ebsReadBytesPerSecond;
      case 'EBS_WRITE_BYTES_PER_SECOND':
        return MetricName.ebsWriteBytesPerSecond;
    }
    throw Exception('$this is not known in enum MetricName');
  }
}

enum MetricStatistic {
  maximum,
  average,
}

extension MetricStatisticValueExtension on MetricStatistic {
  String toValue() {
    switch (this) {
      case MetricStatistic.maximum:
        return 'Maximum';
      case MetricStatistic.average:
        return 'Average';
    }
  }
}

extension MetricStatisticFromString on String {
  MetricStatistic toMetricStatistic() {
    switch (this) {
      case 'Maximum':
        return MetricStatistic.maximum;
      case 'Average':
        return MetricStatistic.average;
    }
    throw Exception('$this is not known in enum MetricStatistic');
  }
}

/// Describes a projected utilization metric of a recommendation option, such as
/// an Amazon EC2 instance. This represents the projected utilization of a
/// recommendation option had you used that resource during the analyzed period.
///
/// Compare the utilization metric data of your resource against its projected
/// utilization metric data to determine the performance difference between your
/// current resource and the recommended option.
/// <note>
/// The <code>Cpu</code> and <code>Memory</code> metrics are the only projected
/// utilization metrics returned when you run the
/// <code>GetEC2RecommendationProjectedMetrics</code> action. Additionally, the
/// <code>Memory</code> metric is returned only for resources that have the
/// unified CloudWatch agent installed on them. For more information, see <a
/// href="https://docs.aws.amazon.com/compute-optimizer/latest/ug/metrics.html#cw-agent">Enabling
/// Memory Utilization with the CloudWatch Agent</a>.
/// </note>
class ProjectedMetric {
  /// The name of the projected utilization metric.
  ///
  /// The following projected utilization metrics are returned:
  ///
  /// <ul>
  /// <li>
  /// <code>Cpu</code> - The projected percentage of allocated EC2 compute units
  /// that would be in use on the recommendation option had you used that resource
  /// during the analyzed period. This metric identifies the processing power
  /// required to run an application on the recommendation option.
  ///
  /// Depending on the instance type, tools in your operating system can show a
  /// lower percentage than CloudWatch when the instance is not allocated a full
  /// processor core.
  ///
  /// Units: Percent
  /// </li>
  /// <li>
  /// <code>Memory</code> - The percentage of memory that would be in use on the
  /// recommendation option had you used that resource during the analyzed period.
  /// This metric identifies the amount of memory required to run an application
  /// on the recommendation option.
  ///
  /// Units: Percent
  /// <note>
  /// The <code>Memory</code> metric is returned only for resources that have the
  /// unified CloudWatch agent installed on them. For more information, see <a
  /// href="https://docs.aws.amazon.com/compute-optimizer/latest/ug/metrics.html#cw-agent">Enabling
  /// Memory Utilization with the CloudWatch Agent</a>.
  /// </note> </li>
  /// </ul>
  final MetricName? name;

  /// The time stamps of the projected utilization metric.
  final List<DateTime>? timestamps;

  /// The values of the projected utilization metrics.
  final List<double>? values;

  ProjectedMetric({
    this.name,
    this.timestamps,
    this.values,
  });
  factory ProjectedMetric.fromJson(Map<String, dynamic> json) {
    return ProjectedMetric(
      name: (json['name'] as String?)?.toMetricName(),
      timestamps: (json['timestamps'] as List?)
          ?.whereNotNull()
          .map(nonNullableTimeStampFromJson)
          .toList(),
      values: (json['values'] as List?)
          ?.whereNotNull()
          .map((e) => e as double)
          .toList(),
    );
  }
}

/// A summary of a finding reason code.
class ReasonCodeSummary {
  /// The name of the finding reason code.
  final FindingReasonCode? name;

  /// The value of the finding reason code summary.
  final double? value;

  ReasonCodeSummary({
    this.name,
    this.value,
  });
  factory ReasonCodeSummary.fromJson(Map<String, dynamic> json) {
    return ReasonCodeSummary(
      name: (json['name'] as String?)?.toFindingReasonCode(),
      value: json['value'] as double?,
    );
  }
}

/// Describes a recommendation export job.
///
/// Use the <code>DescribeRecommendationExportJobs</code> action to view your
/// recommendation export jobs.
///
/// Use the <code>ExportAutoScalingGroupRecommendations</code> or
/// <code>ExportEC2InstanceRecommendations</code> actions to request an export
/// of your recommendations.
class RecommendationExportJob {
  /// The timestamp of when the export job was created.
  final DateTime? creationTimestamp;

  /// An object that describes the destination of the export file.
  final ExportDestination? destination;

  /// The reason for an export job failure.
  final String? failureReason;

  /// The identification number of the export job.
  final String? jobId;

  /// The timestamp of when the export job was last updated.
  final DateTime? lastUpdatedTimestamp;

  /// The resource type of the exported recommendations.
  final ResourceType? resourceType;

  /// The status of the export job.
  final JobStatus? status;

  RecommendationExportJob({
    this.creationTimestamp,
    this.destination,
    this.failureReason,
    this.jobId,
    this.lastUpdatedTimestamp,
    this.resourceType,
    this.status,
  });
  factory RecommendationExportJob.fromJson(Map<String, dynamic> json) {
    return RecommendationExportJob(
      creationTimestamp: timeStampFromJson(json['creationTimestamp']),
      destination: json['destination'] != null
          ? ExportDestination.fromJson(
              json['destination'] as Map<String, dynamic>)
          : null,
      failureReason: json['failureReason'] as String?,
      jobId: json['jobId'] as String?,
      lastUpdatedTimestamp: timeStampFromJson(json['lastUpdatedTimestamp']),
      resourceType: (json['resourceType'] as String?)?.toResourceType(),
      status: (json['status'] as String?)?.toJobStatus(),
    );
  }
}

/// Describes the source of a recommendation, such as an Amazon EC2 instance or
/// Auto Scaling group.
class RecommendationSource {
  /// The Amazon Resource Name (ARN) of the recommendation source.
  final String? recommendationSourceArn;

  /// The resource type of the recommendation source.
  final RecommendationSourceType? recommendationSourceType;

  RecommendationSource({
    this.recommendationSourceArn,
    this.recommendationSourceType,
  });
  factory RecommendationSource.fromJson(Map<String, dynamic> json) {
    return RecommendationSource(
      recommendationSourceArn: json['recommendationSourceArn'] as String?,
      recommendationSourceType: (json['recommendationSourceType'] as String?)
          ?.toRecommendationSourceType(),
    );
  }
}

enum RecommendationSourceType {
  ec2Instance,
  autoScalingGroup,
  ebsVolume,
  lambdaFunction,
}

extension RecommendationSourceTypeValueExtension on RecommendationSourceType {
  String toValue() {
    switch (this) {
      case RecommendationSourceType.ec2Instance:
        return 'Ec2Instance';
      case RecommendationSourceType.autoScalingGroup:
        return 'AutoScalingGroup';
      case RecommendationSourceType.ebsVolume:
        return 'EbsVolume';
      case RecommendationSourceType.lambdaFunction:
        return 'LambdaFunction';
    }
  }
}

extension RecommendationSourceTypeFromString on String {
  RecommendationSourceType toRecommendationSourceType() {
    switch (this) {
      case 'Ec2Instance':
        return RecommendationSourceType.ec2Instance;
      case 'AutoScalingGroup':
        return RecommendationSourceType.autoScalingGroup;
      case 'EbsVolume':
        return RecommendationSourceType.ebsVolume;
      case 'LambdaFunction':
        return RecommendationSourceType.lambdaFunction;
    }
    throw Exception('$this is not known in enum RecommendationSourceType');
  }
}

/// A summary of a recommendation.
class RecommendationSummary {
  /// The AWS account ID of the recommendation summary.
  final String? accountId;

  /// The resource type of the recommendation.
  final RecommendationSourceType? recommendationResourceType;

  /// An array of objects that describe a recommendation summary.
  final List<Summary>? summaries;

  RecommendationSummary({
    this.accountId,
    this.recommendationResourceType,
    this.summaries,
  });
  factory RecommendationSummary.fromJson(Map<String, dynamic> json) {
    return RecommendationSummary(
      accountId: json['accountId'] as String?,
      recommendationResourceType:
          (json['recommendationResourceType'] as String?)
              ?.toRecommendationSourceType(),
      summaries: (json['summaries'] as List?)
          ?.whereNotNull()
          .map((e) => Summary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Describes a projected utilization metric of a recommendation option.
/// <note>
/// The <code>Cpu</code> and <code>Memory</code> metrics are the only projected
/// utilization metrics returned when you run the
/// <code>GetEC2RecommendationProjectedMetrics</code> action. Additionally, the
/// <code>Memory</code> metric is returned only for resources that have the
/// unified CloudWatch agent installed on them. For more information, see <a
/// href="https://docs.aws.amazon.com/compute-optimizer/latest/ug/metrics.html#cw-agent">Enabling
/// Memory Utilization with the CloudWatch Agent</a>.
/// </note>
class RecommendedOptionProjectedMetric {
  /// An array of objects that describe a projected utilization metric.
  final List<ProjectedMetric>? projectedMetrics;

  /// The rank of the recommendation option projected metric.
  ///
  /// The top recommendation option is ranked as <code>1</code>.
  ///
  /// The projected metric rank correlates to the recommendation option rank. For
  /// example, the projected metric ranked as <code>1</code> is related to the
  /// recommendation option that is also ranked as <code>1</code> in the same
  /// response.
  final int? rank;

  /// The recommended instance type.
  final String? recommendedInstanceType;

  RecommendedOptionProjectedMetric({
    this.projectedMetrics,
    this.rank,
    this.recommendedInstanceType,
  });
  factory RecommendedOptionProjectedMetric.fromJson(Map<String, dynamic> json) {
    return RecommendedOptionProjectedMetric(
      projectedMetrics: (json['projectedMetrics'] as List?)
          ?.whereNotNull()
          .map((e) => ProjectedMetric.fromJson(e as Map<String, dynamic>))
          .toList(),
      rank: json['rank'] as int?,
      recommendedInstanceType: json['recommendedInstanceType'] as String?,
    );
  }
}

enum ResourceType {
  ec2Instance,
  autoScalingGroup,
}

extension ResourceTypeValueExtension on ResourceType {
  String toValue() {
    switch (this) {
      case ResourceType.ec2Instance:
        return 'Ec2Instance';
      case ResourceType.autoScalingGroup:
        return 'AutoScalingGroup';
    }
  }
}

extension ResourceTypeFromString on String {
  ResourceType toResourceType() {
    switch (this) {
      case 'Ec2Instance':
        return ResourceType.ec2Instance;
      case 'AutoScalingGroup':
        return ResourceType.autoScalingGroup;
    }
    throw Exception('$this is not known in enum ResourceType');
  }
}

/// Describes the destination Amazon Simple Storage Service (Amazon S3) bucket
/// name and object keys of a recommendations export file, and its associated
/// metadata file.
class S3Destination {
  /// The name of the Amazon S3 bucket used as the destination of an export file.
  final String? bucket;

  /// The Amazon S3 bucket key of an export file.
  ///
  /// The key uniquely identifies the object, or export file, in the S3 bucket.
  final String? key;

  /// The Amazon S3 bucket key of a metadata file.
  ///
  /// The key uniquely identifies the object, or metadata file, in the S3 bucket.
  final String? metadataKey;

  S3Destination({
    this.bucket,
    this.key,
    this.metadataKey,
  });
  factory S3Destination.fromJson(Map<String, dynamic> json) {
    return S3Destination(
      bucket: json['bucket'] as String?,
      key: json['key'] as String?,
      metadataKey: json['metadataKey'] as String?,
    );
  }
}

/// Describes the destination Amazon Simple Storage Service (Amazon S3) bucket
/// name and key prefix for a recommendations export job.
///
/// You must create the destination Amazon S3 bucket for your recommendations
/// export before you create the export job. Compute Optimizer does not create
/// the S3 bucket for you. After you create the S3 bucket, ensure that it has
/// the required permission policy to allow Compute Optimizer to write the
/// export file to it. If you plan to specify an object prefix when you create
/// the export job, you must include the object prefix in the policy that you
/// add to the S3 bucket. For more information, see <a
/// href="https://docs.aws.amazon.com/compute-optimizer/latest/ug/create-s3-bucket-policy-for-compute-optimizer.html">Amazon
/// S3 Bucket Policy for Compute Optimizer</a> in the <i>Compute Optimizer user
/// guide</i>.
class S3DestinationConfig {
  /// The name of the Amazon S3 bucket to use as the destination for an export
  /// job.
  final String? bucket;

  /// The Amazon S3 bucket prefix for an export job.
  final String? keyPrefix;

  S3DestinationConfig({
    this.bucket,
    this.keyPrefix,
  });
  Map<String, dynamic> toJson() {
    final bucket = this.bucket;
    final keyPrefix = this.keyPrefix;
    return {
      if (bucket != null) 'bucket': bucket,
      if (keyPrefix != null) 'keyPrefix': keyPrefix,
    };
  }
}

enum Status {
  active,
  inactive,
  pending,
  failed,
}

extension StatusValueExtension on Status {
  String toValue() {
    switch (this) {
      case Status.active:
        return 'Active';
      case Status.inactive:
        return 'Inactive';
      case Status.pending:
        return 'Pending';
      case Status.failed:
        return 'Failed';
    }
  }
}

extension StatusFromString on String {
  Status toStatus() {
    switch (this) {
      case 'Active':
        return Status.active;
      case 'Inactive':
        return Status.inactive;
      case 'Pending':
        return Status.pending;
      case 'Failed':
        return Status.failed;
    }
    throw Exception('$this is not known in enum Status');
  }
}

/// The summary of a recommendation.
class Summary {
  /// The finding classification of the recommendation.
  final Finding? name;

  /// An array of objects that summarize a finding reason code.
  final List<ReasonCodeSummary>? reasonCodeSummaries;

  /// The value of the recommendation summary.
  final double? value;

  Summary({
    this.name,
    this.reasonCodeSummaries,
    this.value,
  });
  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      name: (json['name'] as String?)?.toFinding(),
      reasonCodeSummaries: (json['reasonCodeSummaries'] as List?)
          ?.whereNotNull()
          .map((e) => ReasonCodeSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
      value: json['value'] as double?,
    );
  }
}

class UpdateEnrollmentStatusResponse {
  /// The enrollment status of the account.
  final Status? status;

  /// The reason for the enrollment status of the account. For example, an account
  /// might show a status of <code>Pending</code> because member accounts of an
  /// organization require more time to be enrolled in the service.
  final String? statusReason;

  UpdateEnrollmentStatusResponse({
    this.status,
    this.statusReason,
  });
  factory UpdateEnrollmentStatusResponse.fromJson(Map<String, dynamic> json) {
    return UpdateEnrollmentStatusResponse(
      status: (json['status'] as String?)?.toStatus(),
      statusReason: json['statusReason'] as String?,
    );
  }
}

/// Describes a utilization metric of a resource, such as an Amazon EC2
/// instance.
///
/// Compare the utilization metric data of your resource against its projected
/// utilization metric data to determine the performance difference between your
/// current resource and the recommended option.
class UtilizationMetric {
  /// The name of the utilization metric.
  ///
  /// The following utilization metrics are available:
  ///
  /// <ul>
  /// <li>
  /// <code>Cpu</code> - The percentage of allocated EC2 compute units that are
  /// currently in use on the instance. This metric identifies the processing
  /// power required to run an application on the instance.
  ///
  /// Depending on the instance type, tools in your operating system can show a
  /// lower percentage than CloudWatch when the instance is not allocated a full
  /// processor core.
  ///
  /// Units: Percent
  /// </li>
  /// <li>
  /// <code>Memory</code> - The percentage of memory that is currently in use on
  /// the instance. This metric identifies the amount of memory required to run an
  /// application on the instance.
  ///
  /// Units: Percent
  /// <note>
  /// The <code>Memory</code> metric is returned only for resources that have the
  /// unified CloudWatch agent installed on them. For more information, see <a
  /// href="https://docs.aws.amazon.com/compute-optimizer/latest/ug/metrics.html#cw-agent">Enabling
  /// Memory Utilization with the CloudWatch Agent</a>.
  /// </note> </li>
  /// <li>
  /// <code>EBS_READ_OPS_PER_SECOND</code> - The completed read operations from
  /// all EBS volumes attached to the instance in a specified period of time.
  ///
  /// Unit: Count
  /// </li>
  /// <li>
  /// <code>EBS_WRITE_OPS_PER_SECOND</code> - The completed write operations to
  /// all EBS volumes attached to the instance in a specified period of time.
  ///
  /// Unit: Count
  /// </li>
  /// <li>
  /// <code>EBS_READ_BYTES_PER_SECOND</code> - The bytes read from all EBS volumes
  /// attached to the instance in a specified period of time.
  ///
  /// Unit: Bytes
  /// </li>
  /// <li>
  /// <code>EBS_WRITE_BYTES_PER_SECOND</code> - The bytes written to all EBS
  /// volumes attached to the instance in a specified period of time.
  ///
  /// Unit: Bytes
  /// </li>
  /// </ul>
  final MetricName? name;

  /// The statistic of the utilization metric.
  ///
  /// The following statistics are available:
  ///
  /// <ul>
  /// <li>
  /// <code>Average</code> - This is the value of Sum / SampleCount during the
  /// specified period, or the average value observed during the specified period.
  /// </li>
  /// <li>
  /// <code>Maximum</code> - The highest value observed during the specified
  /// period. Use this value to determine high volumes of activity for your
  /// application.
  /// </li>
  /// </ul>
  final MetricStatistic? statistic;

  /// The value of the utilization metric.
  final double? value;

  UtilizationMetric({
    this.name,
    this.statistic,
    this.value,
  });
  factory UtilizationMetric.fromJson(Map<String, dynamic> json) {
    return UtilizationMetric(
      name: (json['name'] as String?)?.toMetricName(),
      statistic: (json['statistic'] as String?)?.toMetricStatistic(),
      value: json['value'] as double?,
    );
  }
}

/// Describes the configuration of an Amazon Elastic Block Store (Amazon EBS)
/// volume.
class VolumeConfiguration {
  /// The baseline IOPS of the volume.
  final int? volumeBaselineIOPS;

  /// The baseline throughput of the volume.
  final int? volumeBaselineThroughput;

  /// The burst IOPS of the volume.
  final int? volumeBurstIOPS;

  /// The burst throughput of the volume.
  final int? volumeBurstThroughput;

  /// The size of the volume, in GiB.
  final int? volumeSize;

  /// The volume type.
  ///
  /// This can be <code>gp2</code> for General Purpose SSD, <code>io1</code> or
  /// <code>io2</code> for Provisioned IOPS SSD, <code>st1</code> for Throughput
  /// Optimized HDD, <code>sc1</code> for Cold HDD, or <code>standard</code> for
  /// Magnetic volumes.
  final String? volumeType;

  VolumeConfiguration({
    this.volumeBaselineIOPS,
    this.volumeBaselineThroughput,
    this.volumeBurstIOPS,
    this.volumeBurstThroughput,
    this.volumeSize,
    this.volumeType,
  });
  factory VolumeConfiguration.fromJson(Map<String, dynamic> json) {
    return VolumeConfiguration(
      volumeBaselineIOPS: json['volumeBaselineIOPS'] as int?,
      volumeBaselineThroughput: json['volumeBaselineThroughput'] as int?,
      volumeBurstIOPS: json['volumeBurstIOPS'] as int?,
      volumeBurstThroughput: json['volumeBurstThroughput'] as int?,
      volumeSize: json['volumeSize'] as int?,
      volumeType: json['volumeType'] as String?,
    );
  }
}

/// Describes an Amazon Elastic Block Store (Amazon EBS) volume recommendation.
class VolumeRecommendation {
  /// The AWS account ID of the volume.
  final String? accountId;

  /// An array of objects that describe the current configuration of the volume.
  final VolumeConfiguration? currentConfiguration;

  /// The finding classification for the volume.
  ///
  /// Findings for volumes include:
  ///
  /// <ul>
  /// <li>
  /// <b> <code>NotOptimized</code> </b>—A volume is considered not optimized when
  /// AWS Compute Optimizer identifies a recommendation that can provide better
  /// performance for your workload.
  /// </li>
  /// <li>
  /// <b> <code>Optimized</code> </b>—An volume is considered optimized when
  /// Compute Optimizer determines that the volume is correctly provisioned to run
  /// your workload based on the chosen volume type. For optimized resources,
  /// Compute Optimizer might recommend a new generation volume type.
  /// </li>
  /// </ul>
  final EBSFinding? finding;

  /// The time stamp of when the volume recommendation was last refreshed.
  final DateTime? lastRefreshTimestamp;

  /// The number of days for which utilization metrics were analyzed for the
  /// volume.
  final double? lookBackPeriodInDays;

  /// An array of objects that describe the utilization metrics of the volume.
  final List<EBSUtilizationMetric>? utilizationMetrics;

  /// The Amazon Resource Name (ARN) of the current volume.
  final String? volumeArn;

  /// An array of objects that describe the recommendation options for the volume.
  final List<VolumeRecommendationOption>? volumeRecommendationOptions;

  VolumeRecommendation({
    this.accountId,
    this.currentConfiguration,
    this.finding,
    this.lastRefreshTimestamp,
    this.lookBackPeriodInDays,
    this.utilizationMetrics,
    this.volumeArn,
    this.volumeRecommendationOptions,
  });
  factory VolumeRecommendation.fromJson(Map<String, dynamic> json) {
    return VolumeRecommendation(
      accountId: json['accountId'] as String?,
      currentConfiguration: json['currentConfiguration'] != null
          ? VolumeConfiguration.fromJson(
              json['currentConfiguration'] as Map<String, dynamic>)
          : null,
      finding: (json['finding'] as String?)?.toEBSFinding(),
      lastRefreshTimestamp: timeStampFromJson(json['lastRefreshTimestamp']),
      lookBackPeriodInDays: json['lookBackPeriodInDays'] as double?,
      utilizationMetrics: (json['utilizationMetrics'] as List?)
          ?.whereNotNull()
          .map((e) => EBSUtilizationMetric.fromJson(e as Map<String, dynamic>))
          .toList(),
      volumeArn: json['volumeArn'] as String?,
      volumeRecommendationOptions: (json['volumeRecommendationOptions']
              as List?)
          ?.whereNotNull()
          .map((e) =>
              VolumeRecommendationOption.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Describes a recommendation option for an Amazon Elastic Block Store (Amazon
/// EBS) instance.
class VolumeRecommendationOption {
  /// An array of objects that describe a volume configuration.
  final VolumeConfiguration? configuration;

  /// The performance risk of the volume recommendation option.
  ///
  /// Performance risk is the likelihood of the recommended volume type not
  /// meeting the performance requirement of your workload.
  ///
  /// The lowest performance risk is categorized as <code>0</code>, and the
  /// highest as <code>5</code>.
  final double? performanceRisk;

  /// The rank of the volume recommendation option.
  ///
  /// The top recommendation option is ranked as <code>1</code>.
  final int? rank;

  VolumeRecommendationOption({
    this.configuration,
    this.performanceRisk,
    this.rank,
  });
  factory VolumeRecommendationOption.fromJson(Map<String, dynamic> json) {
    return VolumeRecommendationOption(
      configuration: json['configuration'] != null
          ? VolumeConfiguration.fromJson(
              json['configuration'] as Map<String, dynamic>)
          : null,
      performanceRisk: json['performanceRisk'] as double?,
      rank: json['rank'] as int?,
    );
  }
}

class AccessDeniedException extends _s.GenericAwsException {
  AccessDeniedException({String? type, String? message})
      : super(type: type, code: 'AccessDeniedException', message: message);
}

class InternalServerException extends _s.GenericAwsException {
  InternalServerException({String? type, String? message})
      : super(type: type, code: 'InternalServerException', message: message);
}

class InvalidParameterValueException extends _s.GenericAwsException {
  InvalidParameterValueException({String? type, String? message})
      : super(
            type: type,
            code: 'InvalidParameterValueException',
            message: message);
}

class LimitExceededException extends _s.GenericAwsException {
  LimitExceededException({String? type, String? message})
      : super(type: type, code: 'LimitExceededException', message: message);
}

class MissingAuthenticationToken extends _s.GenericAwsException {
  MissingAuthenticationToken({String? type, String? message})
      : super(type: type, code: 'MissingAuthenticationToken', message: message);
}

class OptInRequiredException extends _s.GenericAwsException {
  OptInRequiredException({String? type, String? message})
      : super(type: type, code: 'OptInRequiredException', message: message);
}

class ResourceNotFoundException extends _s.GenericAwsException {
  ResourceNotFoundException({String? type, String? message})
      : super(type: type, code: 'ResourceNotFoundException', message: message);
}

class ServiceUnavailableException extends _s.GenericAwsException {
  ServiceUnavailableException({String? type, String? message})
      : super(
            type: type, code: 'ServiceUnavailableException', message: message);
}

class ThrottlingException extends _s.GenericAwsException {
  ThrottlingException({String? type, String? message})
      : super(type: type, code: 'ThrottlingException', message: message);
}

final _exceptionFns = <String, _s.AwsExceptionFn>{
  'AccessDeniedException': (type, message) =>
      AccessDeniedException(type: type, message: message),
  'InternalServerException': (type, message) =>
      InternalServerException(type: type, message: message),
  'InvalidParameterValueException': (type, message) =>
      InvalidParameterValueException(type: type, message: message),
  'LimitExceededException': (type, message) =>
      LimitExceededException(type: type, message: message),
  'MissingAuthenticationToken': (type, message) =>
      MissingAuthenticationToken(type: type, message: message),
  'OptInRequiredException': (type, message) =>
      OptInRequiredException(type: type, message: message),
  'ResourceNotFoundException': (type, message) =>
      ResourceNotFoundException(type: type, message: message),
  'ServiceUnavailableException': (type, message) =>
      ServiceUnavailableException(type: type, message: message),
  'ThrottlingException': (type, message) =>
      ThrottlingException(type: type, message: message),
};
